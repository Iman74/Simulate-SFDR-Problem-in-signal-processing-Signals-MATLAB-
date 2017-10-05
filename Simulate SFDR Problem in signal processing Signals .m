%HW #4 FPGA
clear all
clc

Fs = 10e7;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = 10000;                     % Length of signal
t = (0:L-1)*T;                % Time vector

samplefunc=sin(2*pi*20e6*t); 

bit=16;
dither=2;
SNR=4;
%%

noisadd=awgn(samplefunc,SNR,'measured');
fisamplefunc=fi(noisadd);
qsamplefunc=quantize(fisamplefunc,numerictype(true,bit,bit-2),'Round');

ditheradd=awgn(noisadd,dither,'measured',100);
dfisamplefunc=fi(ditheradd);
dqsamplefunc=quantize(dfisamplefunc,numerictype(true,bit,bit-2),'Round');

error=qsamplefunc-fi(noisadd);


%u = r*(2*rand(50000,1) - 1);        % Uniformly distributed (-1,1)
%err = quantize(q,u) - u;


figure (1)
subplot(3,1,1)
plot(t,fi(noisadd))
title('input func')

subplot(3,1,2)
plot(t,qsamplefunc)
title('Quintized')

subplot(3,1,3)
plot(t,error)
%ylim([-.01 .01])
title('Quantization error')




figure (2)
subplot(2,1,1)
plot(t,qsamplefunc)
title('Quintized')

subplot(2,1,2)
plot(t,dqsamplefunc)
%ylim([-.01 .01])
title('Quintized + Dither')

%plot(z,samplefunc);
%plot(z,noisadd);
%plot(z,ditheradd,'o');
%plot(z,fisamplefunc,'.');
%plot(z,qsamplefunc,'*');

%%
%fftqsamplefunc=fft(double(qsamplefunc),Fs);
%fftdqsamplefunc=fft(double(dqsamplefunc),Fs);


figure (3)
subplot(2,1,1)
sfdr(double(qsamplefunc),Fs);
%plot(t,fftqsamplefunc,'o')
title('FFT Quintized')

subplot(2,1,2)
%sfdr(samplefunc);
sfdr(double(dqsamplefunc),Fs);
title('FFT Quintized + Dither')
 