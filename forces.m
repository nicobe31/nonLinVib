%% linear sine sweep
ampl = 1; %N
f0 = 5; %Hz
f1 = 40; %Hz
r = 2; %rate Hz/s
phi0 = 0; %degree
samplingFreq = 100; %Hz

phi0 = phi0*pi/180; % °-> rad
t0 = 0;
t1 = (f1-f0)/r;
t = t0:1/samplingFreq:t1;

arg1 = 2*pi*f0*(t-t0);
arg2 = 2*pi*r*(t-t0).^2/2;
arg = arg1 + arg2 + phi0;

u = ampl*sin(arg);


%% random
% N = 4;
f0 = 5;
f1 = 40;
f2 = 100;
samplingFreqt = 100; %Hz
stepFreq = 100; %pt per Hz
t0 = 0;
t1 = 20;
t = t0:1/samplingFreqt:t1;

N1 = floor((f2-f0)*stepFreq);
N2 = floor(f1-f0)*stepFreq;

phik = (2*pi*rand(N1,1))-pi;
Uk = zeros(N1,1);
Uk(1:N2) = ones(N2,1);

arg1 = 1i*2*pi*[1:N1]'*f2/N1*t;
% arg2 = 1i*diag(phik)*ones(size(arg1));
arg2 = 1i*phik;
% arg = arg1 + arg2;
factor1 = exp(arg1);
factor2 = Uk.*exp(arg2);

sines = bsxfun(@times,factor1, factor2);

u  = sum(sines,1);

y = fft(u);
l = length(t);
fd = abs(y/l);
p2 = f(1:l/2+1);
p2(2:end-1) = 2*p2(2:end-1);
f = samplingFreqt*(0:(l/2))/l;
plot(f,p2)


