%This script computes the linear natural frequencies of the 2 dof system

load('initialMatrix.mat')
[~,d] = eig(K,M);
f = sqrt(diag(d)); %natural frequiencies in rad/s
f = f/2/pi; %natural frequencies in Hz
disp('done last try')

clear d;