% --------------
% rocket_analyze
% --------------
% This script takes the filtered position, velocity, and acceleration data
% from rocket_plot and calculates the average and peak forces of the
% different rockets.  The resulting bar graph characterizes the safety of
% each rocket by comparing the forces imparted during impact.
% 
% ROCKETS
% -------
% A = dense rubber
% B = long light rubber
% C = plastic
% D = propeller
% E = short light rubber

clear
%%
m = 25; %mass of rockets, grams

%% load fitler position, velocity, acceleration
% fast
filt_p_fastA = csvread('filt_p_fastA.csv');
filt_p_fastB = csvread('filt_p_fastB.csv');
filt_p_fastC = csvread('filt_p_fastC.csv');
filt_p_fastD = csvread('filt_p_fastD.csv');
filt_p_fastE = csvread('filt_p_fastE.csv');
%
v_filt_fastA = csvread('v_filt_fastA.csv');
v_filt_fastB = csvread('v_filt_fastB.csv');
v_filt_fastC = csvread('v_filt_fastC.csv');
v_filt_fastD = csvread('v_filt_fastD.csv');
v_filt_fastE = csvread('v_filt_fastE.csv');
%
a_filt_fastA = csvread('a_filt_fastA.csv');
a_filt_fastB = csvread('a_filt_fastB.csv');
a_filt_fastC = csvread('a_filt_fastC.csv');
a_filt_fastD = csvread('a_filt_fastD.csv');
a_filt_fastE = csvread('a_filt_fastE.csv');
% slow
filt_p_slowA = csvread('filt_p_slowA.csv');
filt_p_slowB = csvread('filt_p_slowB.csv');
filt_p_slowC = csvread('filt_p_slowC.csv');
filt_p_slowD = csvread('filt_p_slowD.csv');
filt_p_slowE = csvread('filt_p_slowE.csv');
%
v_filt_slowA = csvread('v_filt_slowA.csv');
v_filt_slowB = csvread('v_filt_slowB.csv');
v_filt_slowC = csvread('v_filt_slowC.csv');
v_filt_slowD = csvread('v_filt_slowD.csv');
v_filt_slowE = csvread('v_filt_slowE.csv');
%
a_filt_slowA = csvread('a_filt_slowA.csv');
a_filt_slowB = csvread('a_filt_slowB.csv');
a_filt_slowC = csvread('a_filt_slowC.csv');
a_filt_slowD = csvread('a_filt_slowD.csv');
a_filt_slowE = csvread('a_filt_slowE.csv');




%% Find IMPACT TIME
% -----------


%detection threshold on acceleration top detect start and end of impact
%other (more robust) algorithms are possible and better
thresh = -.05; 
[T1_fastA, T2_fastA, impactT_fastA] = impactTime_from_accel(a_filt_fastA, thresh)
[T1_fastB, T2_fastB, impactT_fastB] = impactTime_from_accel(a_filt_fastB, thresh);
[T1_fastC, T2_fastC, impactT_fastC] = impactTime_from_accel(a_filt_fastC, thresh);
[T1_fastD, T2_fastD, impactT_fastD] = impactTime_from_accel(a_filt_fastD, thresh);
[T1_fastE, T2_fastE, impactT_fastE] = impactTime_from_accel(a_filt_fastE, thresh);

thresh = -.025; %detection threshold on acceleration
[T1_slowA, T2_slowA, impactT_slowA] = impactTime_from_accel(a_filt_slowA, thresh);
[T1_slowB, T2_slowB, impactT_slowB] = impactTime_from_accel(a_filt_slowB, thresh);
[T1_slowC, T2_slowC, impactT_slowC] = impactTime_from_accel(a_filt_slowC, thresh);
[T1_slowD, T2_slowD, impactT_slowD] = impactTime_from_accel(a_filt_slowD, thresh);
[T1_slowE, T2_slowE, impactT_slowE] = impactTime_from_accel(a_filt_slowE, thresh);


%% filtered plots with found times
% ------------------
figure(21); 
subplot(3,5,1); plot(filt_p_fastA, 'r');hold on
                     plot([T1_fastA+2 T1_fastA+2],[min(filt_p_fastA) max(filt_p_fastA)],'b')
                     plot([T2_fastA+2 T2_fastA+2],[min(filt_p_fastA) max(filt_p_fastA)],'b')
                     title('Filtered Pos: fastA'); 
subplot(3,5,6); plot(v_filt_fastA, 'r');hold on
                     plot([T1_fastA+1 T1_fastA+1],[min(v_filt_fastA) max(v_filt_fastA)],'b')
                     plot([T2_fastA+1 T2_fastA+1],[min(v_filt_fastA) max(v_filt_fastA)],'b')
                     title('Filtered Vel: fastA'); 
subplot(3,5,11); plot(a_filt_fastA, 'r');hold on
                     plot(diff(a_filt_fastA), 'k');
                     plot([T1_fastA T1_fastA],[min(a_filt_fastA) max(a_filt_fastA)],'b')
                     plot([T2_fastA T2_fastA],[min(a_filt_fastA) max(a_filt_fastA)],'b')
                     title('Filtered Accel: fastA'); 

subplot(3,5,2); plot(filt_p_fastB, 'r');hold on
                     plot([T1_fastB+2 T1_fastB+2],[min(filt_p_fastB) max(filt_p_fastB)],'b')
                     plot([T2_fastB+2 T2_fastB+2],[min(filt_p_fastB) max(filt_p_fastB)],'b')
                     title('Filtered Pos: fastB'); 
subplot(3,5,7); plot(v_filt_fastB, 'r');hold on
                     plot([T1_fastB+2 T1_fastB+2],[min(v_filt_fastB) max(v_filt_fastB)],'b')
                     plot([T2_fastB+2 T2_fastB+2],[min(v_filt_fastB) max(v_filt_fastB)],'b')
                     title('Filtered Vel: fastB');                 
subplot(3,5,12); plot(a_filt_fastB, 'r');hold on
                     plot(diff(a_filt_fastB), 'k');
                     plot([T1_fastB T1_fastB],[min(a_filt_fastB) max(a_filt_fastB)],'b')
                     plot([T2_fastB T2_fastB],[min(a_filt_fastB) max(a_filt_fastB)],'b')
                     title('Filtered Accel: fastB'); 
                             
subplot(3,5,3); plot(filt_p_fastC, 'r');hold on
                     plot([T1_fastC+2 T1_fastC+2],[min(filt_p_fastC) max(filt_p_fastC)],'b')
                     plot([T2_fastC+2 T2_fastC+2],[min(filt_p_fastC) max(filt_p_fastC)],'b')
                     title('Filtered Pos: fastC');                     
subplot(3,5,8); plot(v_filt_fastC, 'r');hold on
                     plot([T1_fastC+2 T1_fastC+2],[min(v_filt_fastC) max(v_filt_fastC)],'b')
                     plot([T2_fastC+2 T2_fastC+2],[min(v_filt_fastC) max(v_filt_fastC)],'b')
                     title('Filtered Vel: fastC');                 
subplot(3,5,13); plot(a_filt_fastC, 'r');hold on
                     plot(diff(a_filt_fastC), 'k');
                     plot([T1_fastC T1_fastC],[min(a_filt_fastC) max(a_filt_fastC)],'b')
                     plot([T2_fastC T2_fastC],[min(a_filt_fastC) max(a_filt_fastC)],'b')
                     title('Filtered Accel: fastC'); 
                     
subplot(3,5,4); plot(filt_p_fastD, 'r');hold on
                     plot([T1_fastD+2 T1_fastD+2],[min(filt_p_fastD) max(filt_p_fastD)],'b')
                     plot([T2_fastD+2 T2_fastD+2],[min(filt_p_fastD) max(filt_p_fastD)],'b')
                     title('Filtered Pos: fastD'); 
subplot(3,5,9); plot(v_filt_fastD, 'r');hold on
                     plot([T1_fastD+2 T1_fastD+2],[min(v_filt_fastD) max(v_filt_fastD)],'b')
                     plot([T2_fastD+2 T2_fastD+2],[min(v_filt_fastD) max(v_filt_fastD)],'b')
                     title('Filtered Vel: fastD');                      
subplot(3,5,14); plot(a_filt_fastD, 'r');hold on
                     plot(diff(a_filt_fastD), 'k');
                     plot([T1_fastD T1_fastD],[min(a_filt_fastD) max(a_filt_fastD)],'b')
                     plot([T2_fastD T2_fastD],[min(a_filt_fastD) max(a_filt_fastD)],'b')
                     title('Filtered Accel: fastD'); 
                     
subplot(3,5,5); plot(filt_p_fastE, 'r');hold on
                     plot([T1_fastE+2 T1_fastE+2],[min(filt_p_fastE) max(filt_p_fastE)],'b')
                     plot([T2_fastE+2 T2_fastE+2],[min(filt_p_fastE) max(filt_p_fastE)],'b')
                     title('Filtered Pos: fastE');                      
subplot(3,5,10); plot(v_filt_fastE, 'r');hold on
                     plot([T1_fastE+2 T1_fastE+2],[min(v_filt_fastE) max(v_filt_fastE)],'b')
                     plot([T2_fastE+2 T2_fastE+2],[min(v_filt_fastE) max(v_filt_fastE)],'b')
                     title('Filtered Vel: fastE');                      
subplot(3,5,15); plot(a_filt_fastE, 'r');hold on
                     plot(diff(a_filt_fastE), 'k');
                     plot([T1_fastE T1_fastE],[min(a_filt_fastE) max(a_filt_fastE)],'b')
                     plot([T2_fastE T2_fastE],[min(a_filt_fastE) max(a_filt_fastE)],'b')
                     title('Filtered Accel: fastE');                      

figure(22);  
subplot(3,5,1); plot(filt_p_slowA, 'r');hold on
                     plot([T1_slowA+2 T1_slowA+2],[min(filt_p_slowA) max(filt_p_slowA)],'b')
                     plot([T2_slowA+2 T2_slowA+2],[min(filt_p_slowA) max(filt_p_slowA)],'b')
                     title('Filtered Pos: slowA'); 
subplot(3,5,6); plot(v_filt_slowA, 'r');hold on
                     plot([T1_slowA+1 T1_slowA+1],[min(v_filt_slowA) max(v_filt_slowA)],'b')
                     plot([T2_slowA+1 T2_slowA+1],[min(v_filt_slowA) max(v_filt_slowA)],'b')
                     title('Filtered Vel: slowA'); 
subplot(3,5,11); plot(a_filt_slowA, 'r');hold on
                     plot(diff(a_filt_slowA), 'k');
                     plot([T1_slowA T1_slowA],[min(a_filt_slowA) max(a_filt_slowA)],'b')
                     plot([T2_slowA T2_slowA],[min(a_filt_slowA) max(a_filt_slowA)],'b')
                     title('Filtered Accel: slowA'); 

subplot(3,5,2); plot(filt_p_slowB, 'r');hold on
                     plot([T1_slowB+2 T1_slowB+2],[min(filt_p_slowB) max(filt_p_slowB)],'b')
                     plot([T2_slowB+2 T2_slowB+2],[min(filt_p_slowB) max(filt_p_slowB)],'b')
                     title('Filtered Pos: slowB'); 
subplot(3,5,7); plot(v_filt_slowB, 'r');hold on
                     plot([T1_slowB+2 T1_slowB+2],[min(v_filt_slowB) max(v_filt_slowB)],'b')
                     plot([T2_slowB+2 T2_slowB+2],[min(v_filt_slowB) max(v_filt_slowB)],'b')
                     title('Filtered Vel: slowB');                 
subplot(3,5,12); plot(a_filt_slowB, 'r');hold on
                     plot(diff(a_filt_slowB), 'k');
                     plot([T1_slowB T1_slowB],[min(a_filt_slowB) max(a_filt_slowB)],'b')
                     plot([T2_slowB T2_slowB],[min(a_filt_slowB) max(a_filt_slowB)],'b')
                     title('Filtered Accel: slowB'); 
                             
subplot(3,5,3); plot(filt_p_slowC, 'r');hold on
                     plot([T1_slowC+2 T1_slowC+2],[min(filt_p_slowC) max(filt_p_slowC)],'b')
                     plot([T2_slowC+2 T2_slowC+2],[min(filt_p_slowC) max(filt_p_slowC)],'b')
                     title('Filtered Pos: slowC');                     
subplot(3,5,8); plot(v_filt_slowC, 'r');hold on
                     plot([T1_slowC+2 T1_slowC+2],[min(v_filt_slowC) max(v_filt_slowC)],'b')
                     plot([T2_slowC+2 T2_slowC+2],[min(v_filt_slowC) max(v_filt_slowC)],'b')
                     title('Filtered Vel: slowC');                 
subplot(3,5,13); plot(a_filt_slowC, 'r');hold on
                     plot(diff(a_filt_slowC), 'k');
                     plot([T1_slowC T1_slowC],[min(a_filt_slowC) max(a_filt_slowC)],'b')
                     plot([T2_slowC T2_slowC],[min(a_filt_slowC) max(a_filt_slowC)],'b')
                     title('Filtered Accel: slowC'); 
                     
subplot(3,5,4); plot(filt_p_slowD, 'r');hold on
                     plot([T1_slowD+2 T1_slowD+2],[min(filt_p_slowD) max(filt_p_slowD)],'b')
                     plot([T2_slowD+2 T2_slowD+2],[min(filt_p_slowD) max(filt_p_slowD)],'b')
                     title('Filtered Pos: slowD'); 
subplot(3,5,9); plot(v_filt_slowD, 'r');hold on
                     plot([T1_slowD+2 T1_slowD+2],[min(v_filt_slowD) max(v_filt_slowD)],'b')
                     plot([T2_slowD+2 T2_slowD+2],[min(v_filt_slowD) max(v_filt_slowD)],'b')
                     title('Filtered Vel: slowD');                      
subplot(3,5,14); plot(a_filt_slowD, 'r');hold on
                     plot(diff(a_filt_slowD), 'k');
                     plot([T1_slowD T1_slowD],[min(a_filt_slowD) max(a_filt_slowD)],'b')
                     plot([T2_slowD T2_slowD],[min(a_filt_slowD) max(a_filt_slowD)],'b')
                     title('Filtered Accel: slowD'); 
                     
subplot(3,5,5); plot(filt_p_slowE, 'r');hold on
                     plot([T1_slowE+2 T1_slowE+2],[min(filt_p_slowE) max(filt_p_slowE)],'b')
                     plot([T2_slowE+2 T2_slowE+2],[min(filt_p_slowE) max(filt_p_slowE)],'b')
                     title('Filtered Pos: slowE');                      
subplot(3,5,10); plot(v_filt_slowE, 'r');hold on
                     plot([T1_slowE+2 T1_slowE+2],[min(v_filt_slowE) max(v_filt_slowE)],'b')
                     plot([T2_slowE+2 T2_slowE+2],[min(v_filt_slowE) max(v_filt_slowE)],'b')
                     title('Filtered Vel: slowE');                      
subplot(3,5,15); plot(a_filt_slowE, 'r');hold on
                     plot(diff(a_filt_slowE), 'k');
                     plot([T1_slowE T1_slowE],[min(a_filt_slowE) max(a_filt_slowE)],'b')
                     plot([T2_slowE T2_slowE],[min(a_filt_slowE) max(a_filt_slowE)],'b')
                     title('Filtered Accel: slowE');                      

                     

                     
%% PEAK FORCE: Fmax = m*a_max / v_before_impact
% (to normalize we divide by v_before_impact )
% -----------------------------------------------------------

Fmax_fastA = m*max(abs(a_filt_fastA))/v_filt_fastA(T1_fastA-1);
Fmax_fastB = m*max(abs(a_filt_fastB))/v_filt_fastB(T1_fastB-1);
Fmax_fastC = m*max(abs(a_filt_fastC))/v_filt_fastC(T1_fastC-1);
Fmax_fastD = m*max(abs(a_filt_fastD))/v_filt_fastD(T1_fastD-1);
Fmax_fastE = m*max(abs(a_filt_fastE))/v_filt_fastE(T1_fastE-1);
Fmax_fast = [Fmax_fastA Fmax_fastB Fmax_fastC Fmax_fastD Fmax_fastE];

Fmax_slowA = m*max(abs(a_filt_slowA))/v_filt_slowA(T1_slowA-1);
Fmax_slowB = m*max(abs(a_filt_slowB))/v_filt_slowB(T1_slowB-1);
Fmax_slowC = m*max(abs(a_filt_slowC))/v_filt_slowC(T1_slowC-1);
Fmax_slowD = m*max(abs(a_filt_slowD))/v_filt_slowD(T1_slowD-1);
Fmax_slowE = m*max(abs(a_filt_slowE))/v_filt_slowE(T1_slowE-1);
Fmax_slow = [Fmax_slowA Fmax_slowB Fmax_slowC Fmax_slowD Fmax_slowE];

%% AVERAGE FORCE: Favg = m*(v_2-v_1) / total_impact_time / v_before_impact
% (to normalize we divide by v_before_impact )
% -----------------------------------------------------------------------

Favg_fastA = m*(v_filt_fastA(T1_fastA)-v_filt_fastA(T2_fastA))/impactT_fastA/v_filt_fastA(T1_fastA-1);
Favg_fastB = m*(v_filt_fastB(T1_fastD)-v_filt_fastB(T2_fastB))/impactT_fastB/v_filt_fastB(T1_fastB-1);
Favg_fastC = m*(v_filt_fastC(T1_fastC)-v_filt_fastC(T2_fastC))/impactT_fastC/v_filt_fastC(T1_fastC-1);
Favg_fastD = m*(v_filt_fastD(T1_fastD)-v_filt_fastD(T2_fastD))/impactT_fastD/v_filt_fastD(T1_fastD-1);
Favg_fastE = m*(v_filt_fastE(T1_fastE)-v_filt_fastE(T2_fastE))/impactT_fastE/v_filt_fastE(T1_fastE-1);
Favg_fast = [Favg_fastA Favg_fastB Favg_fastC Favg_fastD Favg_fastE];

Favg_slowA = m*(v_filt_slowA(T1_slowA)-v_filt_slowA(T2_slowA))/impactT_slowA/v_filt_slowA(T1_slowA-1);
Favg_slowB = m*(v_filt_slowB(T1_slowD)-v_filt_slowB(T2_slowB))/impactT_slowB/v_filt_slowB(T1_slowB-1);
Favg_slowC = m*(v_filt_slowC(T1_slowC)-v_filt_slowC(T2_slowC))/impactT_slowC/v_filt_slowC(T1_slowC-1);
Favg_slowD = m*(v_filt_slowD(T1_slowD)-v_filt_slowD(T2_slowD))/impactT_slowD/v_filt_slowD(T1_slowD-1);
Favg_slowE = m*(v_filt_slowE(T1_slowE)-v_filt_slowE(T2_slowE))/impactT_slowE/v_filt_slowE(T1_slowE-1);
Favg_slow = [Favg_slowA Favg_slowB Favg_slowC Favg_slowD Favg_slowE];

%% BAR GRAPHS: ROCKET COMPARISON
% -----------------------------
figure(28);
Xodd = 0.75:4.75;
Xeven = 1.25:5.25;
subplot(211); hold on; title('Force: Fast');
bar(Xodd, Favg_fast, 0.5);  
bar(Xeven, Fmax_fast, 0.5, 'r');
legend('Average Force', 'Peak Force', 'Location', 'NorthWest');
%axis([0 5.99 0 9]);
set(gca,'XTickLabel',{'', 'dense rubber','long light rubber',...
    'plastic','propellor','short light rubber'});

subplot(212); hold on; title('Force: Slow'); 
bar(Xodd, Favg_slow, 0.5); 
bar(Xeven, Fmax_slow, 0.5, 'r');  
legend('Average Force', 'Peak Force', 'Location', 'NorthWest');
%axis([0 5.99 0 3]);
set(gca,'XTickLabel',{'', 'dense rubber','long light rubber',...
    'plastic','propellor','short light rubber'});

