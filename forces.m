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
Nt = 2^13;
Neff = 1e2;
f0 = 5;
f1 = 40;
t0 = 0;
t1 = 20;

t = linspace(t0,t1,Nt);
samplingFreq = 1/(t(2)-t(1)); %Hz

N = Neff*samplingFreq/(f1-f0);
k0 = floor(f0*N/samplingFreq);
k1 = ceil(f1*N/samplingFreq);
% df = (f1-f0)/Neff;
% N1 = floor(f0/df);
% N2 = floor(f1/df);

phik = (2*pi*rand(k1-k0+1,1))-pi;
% Uk = zeros(N1,1);
% Uk(1:N2) = ones(N2,1);

arg1 = 1i*2*pi*[k0:k1]'*samplingFreq/N*t;
% arg2 = 1i*diag(phik)*ones(size(arg1));
arg2 = 1i*phik;
% arg = arg1 + arg2;
arg = bsxfun(@plus, arg1, arg2);
% factor1 = exp(arg1);
% factor2 = Uk.*exp(arg2);

% sines = bsxfun(@times,factor1, factor2);
sines = exp(arg);

u  = real(N^(-1/2)*sum(sines,1));

y = fft(u); 
fd = abs(y/Nt);
p2 = fd(1:Nt/2+1);
p2(2:end-1) = 2*p2(2:end-1);
f = samplingFreq*(0:(Nt/2))/Nt;
plot(f,p2)


