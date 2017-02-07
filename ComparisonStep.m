%% Comparison for different step (average constant acceleration)

tic
h1 = 0.01;
time = 3; %time during which we will analyse the response of the structure
[F,t] = forces('sineSweep',50,5, 40, 1, 2);
tend1 =length(t);
bet = 0.25;
gam = 0.5;
q1 = zeros(2,length(t));
q_d = zeros(2, length(t));
q_dd = zeros(2, length(t));
q_d_s = zeros(2, length(t));
q_s = zeros(2, length(t));
p1 = zeros(2, length(t));
p1(2,:) =F';


S = Ms +h1*gam*C+(h1^2)*bet*Ks;
S_inv = inv(S);

for i = 1 : tend1 - 3
    %prediction
    q_d_s(:,i+1) = q_d(:,i)+(1-gam)*h1*q_dd(:,i);
    q_s(:,i+1) = q1(:,i) + h1*q_d(:,i) + (0.5-bet)*(h1^2)*q_dd(:,i);
    %acceleration caculation
    q_dd(:,i+1) = S_inv*(p1(:,i+1) - C*q_d_s(:,i+1) - Ks*q_s(:,i+1));
    %Correction
    q_d(:,i+1) = q_d_s(:,i+1)+h1*gam*q_dd(:,i+1);
    q1(:,i+1) = q_s(:,i+1)+(h1^2)*bet*q_dd(:,i+1);
end
x1 = 0:h1:time;
toc
figure
hold on
plot(t, q1(2, :));
title('\fontsize{13} pos for h = 5*10^-6');
xlabel('\fontsize{13} Time [s]');
ylabel('\fontsize{13} Speed [m/s]');
hold off


figure
hold on
plot(t, q_d(2, :));
title('\fontsize{13} Speed for h = 5*10^-6');
xlabel('\fontsize{13} Time [s]');
ylabel('\fontsize{13} Speed [m/s]');
hold off

figure
hold on
plot(t, q_dd(2, :));
title('\fontsize{13} Acceleration for h = 5*10^-6');
xlabel('\fontsize{13} Time [s]');
ylabel('\fontsize{13} Acceleration [m/s^2]');
hold off

% tic
% h2 = 1e-5;
% time = 0.3; %time during which we will analyse the response of the structure
% tend2 = round(time/h2)+1;
% bet = 0.25;
% gam = 0.5;
% q2 = zeros(2,tend2);
% q_d = zeros(2, tend2);
% q_dd = zeros(2, tend2);
% q_d_s = zeros(2, tend2);
% q_s = zeros(2, tend2);
% p2 = zeros(2, tend2);
% p2(2,2) = 1/h2;
% 
% S = Ms +h2*gam*C+(h2^2)*bet*Ks;
% S_inv = inv(S);
% 
% for i = 1 : tend2-1
%     % prediction
%     q_d_s(:,i+1) = q_d(:,i)+(1-gam)*h2*q_dd(:,i);
%     q_s(:,i+1) = q2(:,i) + h2*q_d(:,i) + (0.5-bet)*(h2^2)*q_dd(:,i);
%     % acceleration caculation
%     q_dd(:,i+1) = S_inv*(p2(:,i+1) - C*q_d_s(:,i+1) - Ks*q_s(:,i+1));
%     % Correction
%     q_d(:,i+1) = q_d_s(:,i+1)+h2*gam*q_dd(:,i+1);
%     q2(:,i+1) = q_s(:,i+1)+(h2^2)*bet*q_dd(:,i+1);
% end
% x2 = 0:h2:time;
% toc
% 
% tic
% h3 = 1e-4;
% time = 0.3; %time during which we will analyse the response of the structure
% tend3 = round(time/h3)+1;
% bet = 0.25;
% gam = 0.5;
% q3 = zeros(nNode*6-24,tend3);
% q_d = zeros(nNode*6-24, tend3);
% q_dd = zeros(nNode*6-24, tend3);
% q_d_s = zeros(nNode*6-24, tend3);
% q_s = zeros(nNode*6-24, tend3);
% p3 = zeros(nNode*6-24, tend3);
% p3(10*6+2,2) = 1/h3;
% 
% S = Ms +h3*gam*C+(h3^2)*bet*Ks;
% S_inv = inv(S);
% 
% for i = 1 : tend3 - 1
%     %prediction
%     q_d_s(:,i+1) = q_d(:,i)+(1-gam)*h3*q_dd(:,i);
%     q_s(:,i+1) = q3(:,i) + h3*q_d(:,i) + (0.5-bet)*(h3^2)*q_dd(:,i);
%     %acceleration caculation
%     q_dd(:,i+1) = S_inv*(p3(:,i+1) - C*q_d_s(:,i+1) - Ks*q_s(:,i+1));
%     %Correction
%     q_d(:,i+1) = q_d_s(:,i+1)+h3*gam*q_dd(:,i+1);
%     q3(:,i+1) = q_s(:,i+1)+(h3^2)*bet*q_dd(:,i+1);
% end
% x3 = 0:h3:time;
% toc
% 
% tic
% h4 = 1e-3;
% time = 0.3; %time during which we will analyse the response of the structure
% tend4 = round(time/h4)+1;
% bet = 0.25;
% gam = 0.5;
% q4 = zeros(nNode*6-24,tend4);
% q_d = zeros(nNode*6-24, tend4);
% q_dd = zeros(nNode*6-24, tend4);
% q_d_s = zeros(nNode*6-24, tend4);
% q_s = zeros(nNode*6-24, tend4);
% p4 = zeros(nNode*6-24, tend4);
% p4(10*6+2,2) = 1/h4;
% 
% S = Ms +h4*gam*C+(h4^2)*bet*Ks;
% S_inv = inv(S);
% 
% for i = 1 : tend4 - 1
%     %prediction
%     q_d_s(:,i+1) = q_d(:,i)+(1-gam)*h4*q_dd(:,i);
%     q_s(:,i+1) = q4(:,i) + h4*q_d(:,i) + (0.5-bet)*(h4^2)*q_dd(:,i);
%     %acceleration caculation
%     q_dd(:,i+1) = S_inv*(p4(:,i+1) - C*q_d_s(:,i+1) - Ks*q_s(:,i+1));
%     %Correction
%     q_d(:,i+1) = q_d_s(:,i+1)+h4*gam*q_dd(:,i+1);
%     q4(:,i+1) = q_s(:,i+1)+(h4^2)*bet*q_dd(:,i+1);
% end
% x4 = 0:h4:time;
% toc
% 
% % tic
% % h = 0.1;
% % time = 0.3; %time during which we will analyse the response of the structure
% % tend = round(time/h)+1;
% % bet = 0.25;
% % gam = 0.5;
% % q5 = zeros(nNode*6-24,tend);
% % q_d = zeros(nNode*6-24, tend);
% % q_dd = zeros(nNode*6-24, tend);
% % q_d_s = zeros(nNode*6-24, tend);
% % q_s = zeros(nNode*6-24, tend);
% % p = zeros(nNode*6-24, tend);
% % p(10*6+2,2) = 1/h;
% % 
% % S = Ms +h*gam*C+(h^2)*bet*Ks;
% % S_inv = inv(S);
% % 
% % for i = 1 : tend - 1
% %     %prediction
% %     q_d_s(:,i+1) = q_d(:,i)+(1-gam)*h*q_dd(:,i);
% %     q_s(:,i+1) = q5(:,i) + h*q_d(:,i) + (0.5-bet)*(h^2)*q_dd(:,i);
% %     %acceleration caculation
% %     q_dd(:,i+1) = S_inv*(p(:,i+1) - C*q_d_s(:,i+1) - Ks*q_s(:,i+1));
% %     %Correction
% %     q_d(:,i+1) = q_d_s(:,i+1)+h*gam*q_dd(:,i+1);
% %     q5(:,i+1) = q_s(:,i+1)+(h^2)*bet*q_dd(:,i+1);
% % end
% % x5 = 0:h:time;
% % toc
% 
% figure
% hold on
% plot(x1, q1(10*6+2,:),'-g', 'Linewidth',2);
% plot(x2, q2(10*6+2,:),':r','Linewidth',2);
% plot(x3, q3(10*6+2,:),'-c','Linewidth',2);
% % plot(x3, q3(10*6+2,:),'-','Linewidth',2);
% plot(x4, q4(10*6+2,:),'-m','Linewidth',2);
% 
% title('\fontsize{13} Comparison of the displacement');
% xlabel('\fontsize{13} Time [s]');
% ylabel('\fontsize{13} Displacement [m]');
% legend('h=5e-6','h=1e-5','h=1e-4','h=1e-3')
% hold off







