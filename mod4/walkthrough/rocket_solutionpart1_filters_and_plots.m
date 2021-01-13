% -----------
% rocket filters and plot
% -----------
% This script filters the raw position data from 5 different rockets 
% (see below) for 2 different tests (slow and fast) using a low pass  
% filter.  The resulting filtered position data is then differentiated to 
% obtain smoothed velocity and acceleration data.  
% The filter desig (slow and fast) based on visual inspection of the FFT 
% and filtered tracees of the 10 different position data sets. 
%
% ROCKETS
% -------
% A = dense rubber
% B = long light rubber
% C = plastic
% D = propeller
% E = short light rubber 
%
% SCALING AND DIMENSIONS 
% ----------------------
% rocket position: pixels versus time
% video/sampling rate: 6250 frames/second
% pixels to dimension calibration: 47.0027 pixels/inch

clear; close all;

fast_denserubber =load('.\data4rocket\rapido_gomadensa.txt');
slow_denserubber =load('.\data4rocket\lento_gomadensa.txt');
%
fast_longliterubber =load('.\data4rocket\rapido_gomalargaligera.txt');
slow_longliterubber =load('.\data4rocket\lento_gomalargaligera.txt');
%
fast_plastic =load('.\data4rocket\rapido_plastico.txt');
slow_plastic =load('.\data4rocket\lento_plastico.txt');
%
fast_proptip =load('.\data4rocket\rapido_cabezaldeapoyo.txt');
slow_proptip =load('.\data4rocket\lento_cabezaldeapoyo.txt');
%
fast_shortliterubber =load('.\data4rocket\rapido_gomacortaligera.txt');
slow_shortliterubber =load('.\data4rocket\lento_gomacortaligera.txt');

      
%% position data from file
p_fastA_0 = fast_denserubber;       
p_slowA_0 = slow_denserubber;       
p_fastB_0 = fast_longliterubber;    
p_slowB_0 = slow_longliterubber;    
p_fastC_0 = fast_plastic;           
p_slowC_0 = slow_plastic;           
p_fastD_0 = fast_proptip;           
p_slowD_0 = slow_proptip;           
p_fastE_0 = fast_shortliterubber;   
p_slowE_0 = slow_shortliterubber;   

%% length of smoothing filter
lenfilter = 21;
% a delta function kernel
krnl_delta = zeros(1,lenfilter);
krnl_delta(floor(lenfilter/2)+1) = 1;
% a smoothing kernel
krnl_smooth = hanning(lenfilter);
krnl_smooth = krnl_smooth/sum(krnl_smooth);

%% trim length of position of (unfiltered) posiotion data 
% so that is same length as fitlered version
p_fastA = p_fastA_0;       
p_slowA = p_slowA_0;       
p_fastB = p_fastB_0;    
p_slowB = p_slowB_0;    
p_fastC = p_fastC_0;           
p_slowC = p_slowC_0;           
p_fastD = p_fastD_0;           
p_slowD = p_slowD_0;           
p_fastE = p_fastE_0;   
p_slowE = p_fastE_0;   
%
shape = 'valid';
p_fastA = conv(p_fastA,krnl_delta,shape);
p_fastB = conv(p_fastB,krnl_delta,shape);
p_fastC = conv(p_fastC,krnl_delta,shape);
p_fastD = conv(p_fastD,krnl_delta,shape);
p_fastE = conv(p_fastE,krnl_delta,shape);
%
p_slowA = conv(p_slowA,krnl_delta,shape);
p_slowB = conv(p_slowB,krnl_delta,shape);
p_slowC = conv(p_slowC,krnl_delta,shape);
p_slowD = conv(p_slowD,krnl_delta,shape);
p_slowE = conv(p_slowE,krnl_delta,shape);

%% UNFILTERED VELOCITY
% -------------------

%derivate kernel 
krnl = [1 0 -1]/2;  % could use
v_fastA = conv(p_fastA,krnl,'valid');          
v_slowA = conv(p_slowA,krnl,'valid'); 
v_fastB = conv(p_fastB,krnl,'valid');           
v_slowB = conv(p_slowB,krnl,'valid'); 
v_fastC = conv(p_fastC,krnl,'valid');           
v_slowC = conv(p_slowC,krnl,'valid'); 
v_fastD = conv(p_fastD,krnl,'valid');           
v_slowD = conv(p_slowD,krnl,'valid'); 
v_fastE = conv(p_fastE,krnl,'valid');         
v_slowE = conv(p_slowE,krnl,'valid'); 

%% UNFILTERED ACCELERATION
% -----------------------

a_fastA = conv(v_fastA,krnl,'valid');         
a_slowA = conv(v_slowA,krnl,'valid'); 
a_fastB = conv(v_fastB,krnl,'valid'); 
a_slowB = conv(v_slowB,krnl,'valid'); 
a_fastC = conv(v_fastC,krnl,'valid');         
a_slowC = conv(v_slowC,krnl,'valid'); 
a_fastD = conv(v_fastD,krnl,'valid'); 
a_slowD = conv(v_slowD,krnl,'valid'); 
a_fastE = conv(v_fastE,krnl,'valid'); 
a_slowE = conv(v_slowE,krnl,'valid'); 

%% PLOT UNFILTERED POSITION, VELOCITY, AND ACCELERATION TRACES
% -----------------------------------------------------------

%% unfiltered fast plot
% --------------------
figure(1); 
    subplot(3,5,1); hold on; plot(p_fastA);
    title('Position: fastA'); 
    subplot(3,5,6); hold on; plot(v_fastA);
    title('Velocity: fastA'); 
    subplot(3,5,11); hold on; plot(a_fastA);
    title('Acceleration: fastA'); 

    subplot(3,5,2); hold on; plot(p_fastB);
    title('Position: fastB'); 
    subplot(3,5,7); hold on; plot(v_fastB);
    title('Velocity: fastB'); 
    subplot(3,5,12); hold on; plot(a_fastB);
    title('Acceleration: fastB'); 

    subplot(3,5,3); hold on; plot(p_fastC);
    title('Position: fastC'); 
    subplot(3,5,8); hold on; plot(v_fastC);
    title('Velocity: fastC'); 
    subplot(3,5,13); hold on; plot(a_fastC);
    title('Acceleration: fastC'); 

    subplot(3,5,4); hold on; plot(p_fastD);
    title('Position: fastD'); 
    subplot(3,5,9); hold on; plot(v_fastD);
    title('Velocity: fastD'); 
    subplot(3,5,14); hold on; plot(a_fastD);
    title('Acceleration: fastD'); 

    subplot(3,5,5); hold on; plot(p_fastE);
    title('Position: fastE'); 
    subplot(3,5,10); hold on; plot(v_fastE);
    title('Velocity: fastE'); 
    subplot(3,5,15); hold on; plot(a_fastE);
    title('Acceleration: fastE'); 

%% unfiltered slow plot 
% --------------------
figure(2); 
    subplot(3,5,1); hold on; plot(p_slowA);
    title('Position: slowA'); 
    subplot(3,5,6); hold on; plot(v_slowA);
    title('Velocity: slowA'); 
    subplot(3,5,11); hold on; plot(a_slowA);
    title('Acceleration: slowA'); 

    subplot(3,5,2); hold on; plot(p_slowB);
    title('Position: slowB'); 
    subplot(3,5,7); hold on; plot(v_slowB);
    title('Velocity: slowB'); 
    subplot(3,5,12); hold on; plot(a_slowB);
    title('Acceleration: slowB'); 

    subplot(3,5,3); hold on; plot(p_slowC);
    title('Position: slowC'); 
    subplot(3,5,8); hold on; plot(v_slowC);
    title('Velocity: slowC'); 
    subplot(3,5,13); hold on; plot(a_slowC);
    title('Acceleration: slowC'); 

    subplot(3,5,4); hold on; plot(p_slowD);
    title('Position: slowD'); 
    subplot(3,5,9); hold on; plot(v_slowD);
    title('Velocity: slowD'); 
    subplot(3,5,14); hold on; plot(a_slowD);
    title('Acceleration: slowD'); 

    subplot(3,5,5); hold on; plot(p_slowE);
    title('Position: slowE'); 
    subplot(3,5,10); hold on; plot(v_slowE);
    title('Velocity: slowE'); 
    subplot(3,5,15); hold on; plot(a_slowE);
    title('Acceleration: slowE'); 

for m = 1:2
    figure(m);
    for n = 1:5
        subplot(3,5,n); ylabel('pixels'); xlabel('frame number');
        subplot(3,5,n+5); ylabel('pixels/frame'); xlabel('frame number');
        subplot(3,5,n+10); ylabel('pixels/frame^2'); xlabel('frame number');
    end
end

%% FFT ANALYSIS OF RAW POSITION DATA
% ---------------------------------
fft_fastA = abs(fftshift(fft(p_fastA, 4096)));   fft_slowA = abs(fftshift(fft(p_slowA, 4096)));
fft_fastB = abs(fftshift(fft(p_fastB, 4096)));   fft_slowB = abs(fftshift(fft(p_slowB, 4096)));
fft_fastC = abs(fftshift(fft(p_fastC, 4096)));   fft_slowC = abs(fftshift(fft(p_slowC, 4096)));
fft_fastD = abs(fftshift(fft(p_fastD, 4096)));   fft_slowD = abs(fftshift(fft(p_slowD, 4096)));
fft_fastE = abs(fftshift(fft(p_fastE, 4096)));   fft_slowE = abs(fftshift(fft(p_slowE, 4096)));

% frequency range for FFT plot
% ----------------------------
Fs = 6250; %frames/second, sampling frequency
f = (Fs/4096)*([0:(length(fft_fastA)-1)]'-4096/2);

%  FFT plot
% -------------
figure(3); 
subplot(321); plot(f, fft_fastA); title('FFT: fastA');
xlabel('Frequency'); ylabel('magnitude')
subplot(322); plot(f, fft_fastB); title('FFT: fastB');
xlabel('Frequency'); ylabel('magnitude')
subplot(323); plot(f, fft_fastC); title('FFT: fastC');
xlabel('Frequency'); ylabel('magnitude')
subplot(324); plot(f, fft_fastD); title('FFT: fastD');
xlabel('Frequency'); ylabel('magnitude')
subplot(325); plot(f, fft_fastE); title('FFT: fastE');
xlabel('Frequency'); ylabel('magnitude')

%  FFT plot
% -------------
figure(4);
subplot(321); plot(f, fft_slowA); title('FFT: slowA');
xlabel('Frequency'); ylabel('magnitude')
subplot(322); plot(f, fft_slowB); title('FFT: slowB');
xlabel('Frequency'); ylabel('magnitude')
subplot(323); plot(f, fft_slowC); title('FFT: slowC');
xlabel('Frequency'); ylabel('magnitude')
subplot(324); plot(f, fft_slowD); title('FFT: slowD');
xlabel('Frequency'); ylabel('magnitude')
subplot(325); plot(f, fft_slowE); title('FFT: slowE');
xlabel('Frequency'); ylabel('magnitude')

%% FILTERS ON POSITON
% -------

% fast 

shape = 'valid';
filt_p_fastA = conv(p_fastA_0,krnl_smooth,shape);
filt_p_fastB = conv(p_fastB_0,krnl_smooth,shape);
filt_p_fastC = conv(p_fastC_0,krnl_smooth,shape);
filt_p_fastD = conv(p_fastD_0,krnl_smooth,shape);
filt_p_fastE = conv(p_fastE_0,krnl_smooth,shape);

% slow 

filt_p_slowA = conv(p_slowA_0,krnl_smooth,shape);
filt_p_slowB = conv(p_slowB_0,krnl_smooth,shape);
filt_p_slowC = conv(p_slowC_0,krnl_smooth,shape);
filt_p_slowD = conv(p_slowD_0,krnl_smooth,shape);
filt_p_slowE = conv(p_slowE_0,krnl_smooth,shape);



%% FILTERED VELOCITY
% -------------------

krnl = [1 0 -1]/2;
shape = 'valid';
v_filt_fastA = conv(filt_p_fastA,krnl,shape);          
v_filt_slowA = conv(filt_p_slowA,krnl,shape); 
v_filt_fastB = conv(filt_p_fastB,krnl,shape);           
v_filt_slowB = conv(filt_p_slowB,krnl,shape); 
v_filt_fastC = conv(filt_p_fastC,krnl,shape);           
v_filt_slowC = conv(filt_p_slowC,krnl,shape); 
v_filt_fastD = conv(filt_p_fastD,krnl,shape);           
v_filt_slowD = conv(filt_p_slowD,krnl,shape); 
v_filt_fastE = conv(filt_p_fastE,krnl,shape);         
v_filt_slowE = conv(filt_p_slowE,krnl,shape); 

%% FILTERED ACCELERATION
% -----------------------

a_filt_fastA = conv(v_filt_fastA,krnl,shape);         
a_filt_slowA = conv(v_filt_slowA,krnl,shape); 
a_filt_fastB = conv(v_filt_fastB,krnl,shape); 
a_filt_slowB = conv(v_filt_slowB,krnl,shape); 
a_filt_fastC = conv(v_filt_fastC,krnl,shape);         
a_filt_slowC = conv(v_filt_slowC,krnl,shape); 
a_filt_fastD = conv(v_filt_fastD,krnl,shape); 
a_filt_slowD = conv(v_filt_slowD,krnl,shape); 
a_filt_fastE = conv(v_filt_fastE,krnl,shape); 
a_filt_slowE = conv(v_filt_slowE,krnl,shape); 

%% FFT ANALYSIS OF RAW VEL DATA
% ---------------------------------
fft_v_fastA = abs(fftshift(fft(v_fastA, 4096)));   fft_v_slowA = abs(fftshift(fft(v_slowA, 4096)));
fft_v_fastB = abs(fftshift(fft(v_fastB, 4096)));   fft_v_slowB = abs(fftshift(fft(v_slowB, 4096)));
fft_v_fastC = abs(fftshift(fft(v_fastC, 4096)));   fft_v_slowC = abs(fftshift(fft(v_slowC, 4096)));
fft_v_fastD = abs(fftshift(fft(v_fastD, 4096)));   fft_v_slowD = abs(fftshift(fft(v_slowD, 4096)));
fft_v_fastE = abs(fftshift(fft(v_fastE, 4096)));   fft_v_slowE = abs(fftshift(fft(v_slowE, 4096)));

%% FFT ANALYSIS OF FILTERED VEL DATA
% ---------------------------------
fft_filt_v_fastA = abs(fftshift(fft(v_filt_fastA, 4096)));   fft_filt_v_slowA = abs(fftshift(fft(v_filt_slowA, 4096)));
fft_filt_v_fastB = abs(fftshift(fft(v_filt_fastB, 4096)));   fft_filt_v_slowB = abs(fftshift(fft(v_filt_slowB, 4096)));
fft_filt_v_fastC = abs(fftshift(fft(v_filt_fastC, 4096)));   fft_filt_v_slowC = abs(fftshift(fft(v_filt_slowC, 4096)));
fft_filt_v_fastD = abs(fftshift(fft(v_filt_fastD, 4096)));   fft_filt_v_slowD = abs(fftshift(fft(v_filt_slowD, 4096)));
fft_filt_v_fastE = abs(fftshift(fft(v_filt_fastE, 4096)));   fft_filt_v_slowE = abs(fftshift(fft(v_filt_slowE, 4096)));

%  FFT plot
% -------------
figure(13); 
subplot(321); semilogy(f, fft_v_fastA); title('FFT: V fastA - orig and filtered');
hold on;  semilogy(f, fft_filt_v_fastA,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(322); semilogy(f, fft_v_fastB); title('FFT: V fastB - orig and filtered');
hold on;  semilogy(f, fft_filt_v_fastB,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(323); semilogy(f, fft_v_fastC); title('FFT: V fastC - orig and filtered');
hold on;  semilogy(f, fft_filt_v_fastC,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(324); semilogy(f, fft_v_fastD); title('FFT: V fastD - orig and filtered');
hold on;  semilogy(f, fft_filt_v_fastD,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(325); semilogy(f, fft_v_fastE); title('FFT: V fastE - orig and filtered');
hold on;  semilogy(f, fft_filt_v_fastE,'r')
xlabel('Frequency'); ylabel('log magnitude')

%  FFT plot
% -------------
figure(14);
subplot(321); semilogy(f, fft_v_slowA); title('FFT: V slowA - orig and filtered');
hold on;  semilogy(f, fft_filt_v_slowA,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(322); semilogy(f, fft_v_slowB); title('FFT: V slowB - orig and filtered');
hold on;  semilogy(f, fft_filt_v_slowB,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(323); semilogy(f, fft_v_slowC); title('FFT: V slowC - orig and filtered');
hold on;  semilogy(f, fft_filt_v_slowC,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(324); semilogy(f, fft_v_slowD); title('FFT: V slowD - orig and filtered');
hold on;  semilogy(f, fft_filt_v_slowD,'r')
xlabel('Frequency'); ylabel('log magnitude')
subplot(325); semilogy(f, fft_v_slowE); title('FFT: V slowE - orig and filtered');
hold on;  semilogy(f, fft_filt_v_slowE,'r')
xlabel('Frequency'); ylabel('log magnitude')


%% PLOT FILTERED POSITION, VELOCITY, AND ACCELERATION TRACES
% -----------------------------------------------------------

% filtered fast plot
% ------------------
figure(1); 
subplot(3,5,1); plot(filt_p_fastA, 'r');
subplot(3,5,6); plot(v_filt_fastA, 'r');
subplot(3,5,11); plot(a_filt_fastA, 'r');

subplot(3,5,2); plot(filt_p_fastB, 'r');
subplot(3,5,7); plot(v_filt_fastB, 'r');
subplot(3,5,12); plot(a_filt_fastB, 'r');

subplot(3,5,3); plot(filt_p_fastC, 'r');
subplot(3,5,8); plot(v_filt_fastC, 'r');
subplot(3,5,13); plot(a_filt_fastC, 'r');

subplot(3,5,4); plot(filt_p_fastD, 'r');
subplot(3,5,9); plot(v_filt_fastD, 'r');
subplot(3,5,14); plot(a_filt_fastD, 'r');

subplot(3,5,5); plot(filt_p_fastE, 'r');
subplot(3,5,10); plot(v_filt_fastE, 'r');
subplot(3,5,15); plot(a_filt_fastE, 'r');

% filtered slow plot
% ------------------
figure(2); 
subplot(3,5,1); plot(filt_p_slowA, 'r');
subplot(3,5,6); plot(v_filt_slowA, 'r');
subplot(3,5,11); plot(a_filt_slowA, 'r');

subplot(3,5,2); plot(filt_p_slowB, 'r');
subplot(3,5,7); plot(v_filt_slowB, 'r');
subplot(3,5,12); plot(a_filt_slowB, 'r');

subplot(3,5,3); plot(filt_p_slowC, 'r');
subplot(3,5,8); plot(v_filt_slowC, 'r');
subplot(3,5,13); plot(a_filt_slowC, 'r');

subplot(3,5,4); plot(filt_p_slowD, 'r');
subplot(3,5,9); plot(v_filt_slowD, 'r');
subplot(3,5,14); plot(a_filt_slowD, 'r');

subplot(3,5,5); plot(filt_p_slowE, 'r');
subplot(3,5,10); plot(v_filt_slowE, 'r');
subplot(3,5,15); plot(a_filt_slowE, 'r');



%% just filtered plots 
% ------------------

figure(11); 
subplot(3,5,1); plot(filt_p_fastA, 'r');
                     title('Filtered Pos: fastA'); 
subplot(3,5,6); plot(v_filt_fastA, 'r');
                     title('Filtered Vel: fastA'); 
subplot(3,5,11); plot(a_filt_fastA, 'r');
                     title('Filtered Accel: fastA'); 

subplot(3,5,2); plot(filt_p_fastB, 'r');
                     title('Filtered Pos: fastB'); 
subplot(3,5,7); plot(v_filt_fastB, 'r');
                     title('Filtered Vel: fastB');                 
subplot(3,5,12); plot(a_filt_fastB, 'r');
                     title('Filtered Accel: fastB'); 
                             
subplot(3,5,3); plot(filt_p_fastC, 'r');
                     title('Filtered Pos: fastC');                     
subplot(3,5,8); plot(v_filt_fastC, 'r');
                     title('Filtered Vel: fastC');                 
subplot(3,5,13); plot(a_filt_fastC, 'r');
                     title('Filtered Accel: fastC'); 
                     
subplot(3,5,4); plot(filt_p_fastD, 'r');
                     title('Filtered Pos: fastD'); 
subplot(3,5,9); plot(v_filt_fastD, 'r');
                     title('Filtered Vel: fastD');                      
subplot(3,5,14); plot(a_filt_fastD, 'r');
                     title('Filtered Accel: fastD'); 
                     
subplot(3,5,5); plot(filt_p_fastE, 'r');
                     title('Filtered Pos: fastE');                      
subplot(3,5,10); plot(v_filt_fastE, 'r');
                     title('Filtered Vel: fastE');                      
subplot(3,5,15); plot(a_filt_fastE, 'r');
                     title('Filtered Accel: fastE');                      

figure(12);  
subplot(3,5,1); plot(filt_p_slowA, 'r');
                     title('Filtered Pos: slowA'); 
subplot(3,5,6); plot(v_filt_slowA, 'r');
                     title('Filtered Vel: slowA'); 
subplot(3,5,11); plot(a_filt_slowA, 'r');
                     title('Filtered Accel: slowA'); 

subplot(3,5,2); plot(filt_p_slowB, 'r');
                     title('Filtered Pos: slowB'); 
subplot(3,5,7); plot(v_filt_slowB, 'r');
                     title('Filtered Vel: slowB');                 
subplot(3,5,12); plot(a_filt_slowB, 'r');
                     title('Filtered Accel: slowB'); 
                             
subplot(3,5,3); plot(filt_p_slowC, 'r');
                     title('Filtered Pos: slowC');                     
subplot(3,5,8); plot(v_filt_slowC, 'r');
                     title('Filtered Vel: slowC');                 
subplot(3,5,13); plot(a_filt_slowC, 'r');
                     title('Filtered Accel: slowC'); 
                     
subplot(3,5,4); plot(filt_p_slowD, 'r');
                     title('Filtered Pos: slowD'); 
subplot(3,5,9); plot(v_filt_slowD, 'r');
                     title('Filtered Vel: slowD');                      
subplot(3,5,14); plot(a_filt_slowD, 'r');
                     title('Filtered Accel: slowD'); 
                     
subplot(3,5,5); plot(filt_p_slowE, 'r');
                     title('Filtered Pos: slowE');                      
subplot(3,5,10); plot(v_filt_slowE, 'r');
                     title('Filtered Vel: slowE');                      
subplot(3,5,15); plot(a_filt_slowE, 'r');
                     title('Filtered Accel: slowE');                      

for m = 11:12
    figure(m);
    for n = 1:5
        subplot(3,5,n); ylabel('pixels'); xlabel('frame number');
        subplot(3,5,n+5); ylabel('pixels/frame'); xlabel('frame number');
        subplot(3,5,n+10); ylabel('pixels/frame^2'); xlabel('frame number');
    end
end         
%% save filtered position, vel, accel data to file

csvwrite('filt_p_fastA.csv',filt_p_fastA)
csvwrite('filt_p_fastB.csv',filt_p_fastB)
csvwrite('filt_p_fastC.csv',filt_p_fastC)
csvwrite('filt_p_fastD.csv',filt_p_fastD)
csvwrite('filt_p_fastE.csv',filt_p_fastE)

csvwrite('v_filt_fastA.csv',v_filt_fastA)
csvwrite('v_filt_fastB.csv',v_filt_fastB)
csvwrite('v_filt_fastC.csv',v_filt_fastC)
csvwrite('v_filt_fastD.csv',v_filt_fastD)
csvwrite('v_filt_fastE.csv',v_filt_fastE)

csvwrite('a_filt_fastA.csv',a_filt_fastA)
csvwrite('a_filt_fastB.csv',a_filt_fastB)
csvwrite('a_filt_fastC.csv',a_filt_fastC)
csvwrite('a_filt_fastD.csv',a_filt_fastD)
csvwrite('a_filt_fastE.csv',a_filt_fastE)

%

csvwrite('filt_p_slowA.csv',filt_p_slowA)
csvwrite('filt_p_slowB.csv',filt_p_slowB)
csvwrite('filt_p_slowC.csv',filt_p_slowC)
csvwrite('filt_p_slowD.csv',filt_p_slowD)
csvwrite('filt_p_slowE.csv',filt_p_slowE)

csvwrite('v_filt_slowA.csv',v_filt_slowA)
csvwrite('v_filt_slowB.csv',v_filt_slowB)
csvwrite('v_filt_slowC.csv',v_filt_slowC)
csvwrite('v_filt_slowD.csv',v_filt_slowD)
csvwrite('v_filt_slowE.csv',v_filt_slowE)

csvwrite('a_filt_slowA.csv',a_filt_slowA)
csvwrite('a_filt_slowB.csv',a_filt_slowB)
csvwrite('a_filt_slowC.csv',a_filt_slowC)
csvwrite('a_filt_slowD.csv',a_filt_slowD)
csvwrite('a_filt_slowE.csv',a_filt_slowE)
            
