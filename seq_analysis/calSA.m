function calSA(y,Fs,N)
%% spectrum analysis for time squence
    % input:
    %   y is a symbolic-form function
    %   Fs is sampling frequency,N is number of sample points
    % output:
    %   graph of spectrum
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: March 31st, 2016

%% arguments check
if(nargin ~= 3)
    error('wrong arguments');
end

%% function transfer
f = matlabFunction(y);
t = 0:1/Fs:(N-1)/Fs;
data = f(t)+normrnd(0,1,1,N);

%% original spectrogram
figure(1)
Fy = Fs*(0:round(N/2)-1)/N; % f = fs*(n-1)/N
Y = fft(data,N);
YA = Y.*conj(Y)/N;
subplot(2,1,1);
plot(Fy,YA(1:round(N/2)));
title('Discrete Fourier spectrum graph');
xlabel('frequency(Hz)');

%% correlation coefficient figure
Cx = xcorr(data,'unbiased');
Cxk = fft(Cx,N);
CA = abs(Cxk);
t = 0:round(N/2)-1;
k = t*Fs/N;
subplot(2,1,2)
plot(k,CA(1:round(N/2)),'r');
title('Spectral analysis autocorrelation coefficient method');
xlabel('frequency(Hz)');
