% Exercise Frequency Domain Filtering Noise and Single Interface Distance
% Moving Avg and Ensemble Avg

%% Load Data
data0 = csvread('ToFData.csv');
data = data0(:,1)';  % get first sample
%data = mean(data0') ;

N = length(data);
tt = [0:(N-1)]*12.5e-6; % generate X axis

% plot first sample
figure(1)
plot(tt,data)
xlabel('time (seconds)')
ylabel('Voltage (V)')
title('Original Data')
pause;

%% Physical Frequencies
sample_freq = 80;   %in kHz   (1 / 12.5 microsecond sample interval)
frequencies_physical = [-N/2:N/2 - 1] *sample_freq / (N);

%% get FFT
freq_spectrum = fftshift( fft ( data ) );


%%

dataMmovingavg = data;
dataMffmovingavg = freq_spectrum;
dataMenseble = data;
dataMffensemble = freq_spectrum;
count = 0;
for winsz = [3 5 10 50]
    count = count + 1;
    
    %local averaging
    flt = ones(winsz,1);
    flt = flt / length(flt);
    data_sm = conv(data,flt,'same');
    dataMmovingavg = [dataMmovingavg ; data_sm]; 
    %
    freq_spectrum = fftshift( fft ( data_sm ) );
    dataMffmovingavg = [dataMffmovingavg ; freq_spectrum];
    
    %ensemble averaging
    data_sme = mean(data0(:,1:winsz)') ;
    dataMenseble = [dataMenseble ; data_sme]; 
    %   
    freq_spectrume = fftshift( fft ( data_sme ) );
    dataMffensemble = [dataMffensemble ; freq_spectrume];
end

lgnd{1} = 'Orig data';
lgnd{2} = 'MA - 3';
lgnd{3} = 'MA - 5';
lgnd{4} = 'MA - 10';
lgnd{5} = 'MA - 50';

lgnd_ens{1} = 'Orig data';
lgnd_ens{2} = 'Ensemble - 3';
lgnd_ens{3} = 'Ensemble - 5';
lgnd_ens{4} = 'Ensemble - 10';
lgnd_ens{5} = 'Ensemble - 50';

figure(2)
plot(tt,dataMmovingavg(3,:))
set(gca,'XTick', linspace(0:0.1:0.001) ); 
pause;

figure(203)
for ii = 1:5
    subplot(5,1,ii)
    plot(tt, dataMmovingavg(ii,:))
    xlabel('time (sec)')
    ylabel('Voltage (V)')
    title(lgnd(ii))
end


figure(204)
for ii = 1:5
    subplot(5,1,ii)
    plot(frequencies_physical, abs(dataMffmovingavg(ii,:)))
    xlabel('Frequency (kHz)')
    ylabel('Magnitude')
    title(['Freq Spectrum. ' lgnd{ii}])
end


figure(303)
for ii = 1:5
    subplot(5,1,ii)
    plot(tt, dataMenseble(ii,:))
    xlabel('time (sec)')
    ylabel('Voltage (V)')
    title(lgnd_ens(ii))
end

figure(304)
for ii = 1:5
    subplot(5,1,ii)
    plot(frequencies_physical, abs(dataMffensemble(ii,:)))
    xlabel('Frequency (kHz)')
    ylabel('Magnitude')
    title(['Freq Spectrum. ' lgnd_ens{ii}])
end

