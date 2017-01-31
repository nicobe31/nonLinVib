clear all
close all

nnnnnttttt = 101;
x = linspace(-10,10,nnnnnttttt);
xd = linspace(-10,10,nnnnnttttt);
x = x';
xd = xd';
xdd = x.^3;
mass=1;
p = 0;
f = p - mass*xdd + 0.1*rand(nnnnnttttt,1);

%%
m=3; %order displacement
n=0; %order velocity
nt = length(x);

% matrix X construction
X = zeros(nt,(m+1)*(n+1));
for i = m:-1:0
    for j = n:-1:0
       X(:,(m-i)*(n+1)+(n+1-j)) = x.^i.*xd.^j;
    end
end

% least square
Xt = X';
b = (Xt*f)\(Xt*X);

yy = X*b';
plot(x,f,x,yy);

% error
sigma = var(f); % j'ai un gros doute la dessus :/ 
MSE = 100/(nt*sigma) * sum((f-yy).^2);
MSEpc = MSE*100;





