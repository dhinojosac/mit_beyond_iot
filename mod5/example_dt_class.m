

%% 
% Manufacturing quality data example
%
% The columns of the data are: Feature 1 Length,  Feature 1 Width,  Feature
% 2 Length, and Feature 2 Width,  with Label (1,0,2)  Pass/Fail/Rework
%
% A decision tree is a set of simple rules, such as "if the Part1 length is
% less than 5.45, classify the specimen as fail." Decision trees are
% nonparametric because they do not require any assumptions about the
% distribution of the variables.
%
% Currently, two of the four features are selected in order to develop a
% predictor of part quality. It is proposed to use a Decision Tree in order
% to classify a part as Pass, Rework, or Fail.
%
%


%%
% load data - Get Attributes and Label
%

datain = xlsread('manufacturingqualitydata.xlsx');
Xin = datain(:,1:4);
pause
Yquality = [];
for ii = 1:length(datain(:,end))
    if (datain(ii,end) == 1)
        Yquality{ii} = 'pass';
    end
    if (datain(ii,end) == 0)
        Yquality{ii} = 'fail';
    end
    if (datain(ii,end) == 2)
        Yquality{ii} = 'rework';
    end
end
Yquality = Yquality';

%%
% configuration flag 
%

%Pruning
bPrune = 1;

%%
% scatter plot for 2 of the features

figure(10)
gscatter(Xin(:,1), Xin(:,2), Yquality,'grb','osd');
xlabel('Feature1 length');
ylabel('Feature1 width');
N = size(Xin,1);



%% 
% Classify with decision tree
%

% A decision tree is a set of simple rules, 
% such as "if the Part1 length is less 
% than 5.45, classify the specimen as fail." 
% Decision trees are nonparametric because 
% they do not require any assumptions about 
% the distribution of the variables.

% The fitctree function creates a decision tree.
% Create a decision tree for the measurment data
% and see how well it classifies the parts;

Xsub = Xin(:,1:2);
t = fitctree(Xsub, Yquality,'PredictorNames',{'Feat1W' 'Feat1L' });

% It's interesting to see how the decision tree
% method divides the plane. 

%%
% visualize the regions assigned to each Quality Level.

% create observsation over the full domain 
%[length1,width1] = meshgrid(4:.1:8,2:.1:4.5);
[length1,width1] = meshgrid(floor(min(Xsub(:,1))):.1:ceil(max(Xsub(:,1))),  floor(min(Xsub(:,2))):.1:ceil(max(Xsub(:,2))));
length1 = length1(:);
width1  = width1(:);

figure(20)
[groupname,node] = predict(t,[length1 width1]);
gscatter(length1,width1,groupname,'rgb','sod')

%%
% Another way to visualize the decision tree 
% is to draw a diagram of the decision rule 
% and class assignments.

%figure(30)
view(t,'Mode','graph');

%This cluttered-looking tree uses a series of rules ... DESCRIBE HOW IT
%WORKS

%% 
% Compute the resubstitution error and the cross-validation error.

% The observations with known class labels are usually called the training
% data. Resubstitution error is the misclassification error (the proportion
% of misclassified observations) on the training set.

% Usually people are more interested in the test error (also referred to as
% generalization error), which is the expected prediction error on an
% independent set. In fact, the resubstitution error will likely
% under-estimate the test error.

% In case you don't have another labeled data set, you can simulate one by
% doing cross-validation. A stratified 10-fold cross-validation is a
% popular choice for estimating the test error on classification
% algorithms. It randomly divides the training set into 10 disjoint
% subsets. Each subset has roughly equal size and roughly the same class
% proportions as in the training set. Remove one subset, train the
% classification model using the other nine subsets, and use the trained
% model to classify the removed subset. You could repeat this by removing
% each of the ten subsets one at a time.

% Because cross-validation randomly divides data, its outcome depends on
% the initial random seed.

% use cvpartition to generate 10 disjoint stratified subsets.
cp = cvpartition(Yquality,'KFold',10);

%%
% Compute the resubstitution error and the cross-validation error for
% decision tree.

% resubLoss --- Classification error by resubstitution.
dtResubErr = resubLoss(t)

% cvloss --- Classification error by cross-validation.
cvt = crossval(t,'CVPartition',cp);
dtCVErr = kfoldLoss(cvt)

% For the decision tree algorithm, the cross-validation error estimate is
% typically significantly larger than the resubstitution error. This shows
% that the generated tree overfits the training set. In other words, this
% is a tree that classifies the original training set well, but the
% structure of the tree is sensitive to this particular training set so
% that its performance on new data is likely to degrade. It is often
% possible to find a simpler tree that performs better than a more complex
% tree on new data.

%%
% Try pruning the tree. First compute the resubstitution error for various
% subsets of the original tree. Then compute the cross-validation error for
% these sub-trees. A graph shows that the resubstitution error is overly
% optimistic. It always decreases as the tree size grows, but beyond a
% certain point, increasing the tree size increases the cross-validation
% error rate.

figure(40)
resubcost = resubLoss(t,'Subtrees','all');
[cost,secost,ntermnodes,bestlevel] = cvloss(t,'Subtrees','all');
plot(ntermnodes,cost,'b-', ntermnodes,resubcost,'r--')
figure(gcf);
xlabel('Number of terminal nodes');
ylabel('Cost (misclassification error)')
legend('Cross-validation','Resubstitution')

%
% Which tree should you choose? A simple rule would be to choose the tree
% with the smallest cross-validation error. While this may be satisfactory,
% you might prefer to use a simpler tree if it is roughly as good as a more
% complex tree. For this example, take the simplest tree that is within one
% standard error of the minimum. That's the default rule used by the cvloss
% method of ClassificationTree.

% You can show this on the graph by computing a cutoff value that is equal
% to the minimum cost plus one standard error. The "best" level computed by
% the cvloss method is the smallest tree under this cutoff. (Note that
% bestlevel=0 corresponds to the unpruned tree, so you have to add 1 to use
% it as an index into the vector outputs from cvloss.)

[mincost,minloc] = min(cost);
cutoff = mincost + secost(minloc);
hold on
plot([0 20], [cutoff cutoff], 'k:')
plot(ntermnodes(bestlevel+1), cost(bestlevel+1), 'mo')
legend('Cross-validation','Resubstitution','Min + 1 std. err.','Best choice')
hold off

%%
if(bPrune)
    % Finally, you can examine the 'best' pruned tree and compute the 
    % estimated misclassification error for it.

    pt = prune(t,'Level',bestlevel);
    view(pt,'Mode','graph')
    cost(bestlevel+1)

    % visualize the regions assigned to each Quality Level for pruned tree
    figure(50)
    [groupname,node] = predict(pt,[length1 width1]);
    gscatter(length1,width1,groupname,'rgb','sod')

end

%%
% The above is not an ideal analysis of the data.
%
% Using the other feature measurements instead of, or in addition to, 
% the Feature1 measurements may lead to better classification. 

if(1)
    figure(100)
    gscatter(Xin(:,1), Xin(:,3), Yquality,'grb','osd');
    xlabel('Feature1 length');
    ylabel('Feature2 length');
    N = size(Xin,1);
    title('Feature1 length vs Feature2 length')

    figure(110)
    gscatter(Xin(:,1), Xin(:,4), Yquality,'grb','osd');
    xlabel('Feature1 length');
    ylabel('Feature2 width');
    N = size(Xin,1);
    title('Feature1 length vs Feature2 width')

    figure(120)
    gscatter(Xin(:,2), Xin(:,3), Yquality,'grb','osd');
    xlabel('Feature1 width');
    ylabel('Feature2 length');
    N = size(Xin,1);
    title('Feature1 width vs Feature2 length')

    figure(130)
    gscatter(Xin(:,2), Xin(:,4), Yquality,'grb','osd');
    xlabel('Feature1 width');
    ylabel('Feature2 width');
    N = size(Xin,1);
    title('Feature1 width vs Feature2 width')

    figure(140)
    gscatter(Xin(:,3), Xin(:,4), Yquality,'grb','osd');
    xlabel('Feature2 length');
    ylabel('Feature2 width');
    N = size(Xin,1);
    title('Feature2 length vs Feature2 width')

end


% Also, different classification algorithms may work better. 

% In general it will be important to perform the analysis on other 
% data sets and compare different algorithms. 

% TreeBagger perform bootstrap aggregation for an ensemble of decision
% trees...

