q = rand(2,1000,3);

deltaq = q(1,:,1) - q(2,:,1);
deltaqd = q(1,:,2) - q(2,:,2);
deltaqdd = q(1,:,3) - q(2,:,3);
% peut etre changer, fct de ce que renvois le prof

plot3(deltaq,deltaqd,deltaqdd,'ko')