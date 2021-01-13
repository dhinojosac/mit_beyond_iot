% ----------
% impactTime
% ----------
% This function takes in filtered rocket acceleration data and outputs 
% the total impact time.  The total impact time is determined by seeking 
% the local minimum/maximum immediately before and after the peak 
% acceleration.

function [T1, T2, impactT] = impactTime_from_accel(a,thresh)

diff_a = diff(a); %the deriv of accel is jerk

imin = find(a == min(a)); %index of minimum

found = 0;
n = imin-1;
while (found == 0)
    %if (diff_a(n) >= 0)
    if (a(n) >= thresh)
        T1 = n+1;
        found = 1;
    else
        n = n-1;
    end
end

found = 0;
n = imin+1;
while (found == 0)
    %if (diff_a(n) <= 0)
    if (a(n) >= thresh)
        T2 = n-1;
        found = 1;
    else
        n = n+1;
    end
end

impactT = T2-T1;
end
