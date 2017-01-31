clear all
close all

q = rand(2,1000,3);

sizeQ = size(q);
deltaQ = zeros(3,sizeQ(2));
deltaQ(1,:) = q(1,:,1) - q(2,:,1);
deltaQ(2,:) = q(1,:,2) - q(2,:,2);
deltaQ(3,:) = q(1,:,3) - q(2,:,3);
% peut etre changer, fct de ce que renvois le prof

fig3d = figure('Name','ASM 3D');
plot3(deltaQ(1,:),deltaQ(2,:),deltaQ(3,:),'ko');
xlabel('x:distance');
ylabel('y:velocity');
zlabel('z:acceleration');

promp = sprintf('Which do you want? axes-value (x-0) \n');
sliceStrg = input(promp,'s');
sliceAxeStrg = sliceStrg(1);
switch sliceAxeStrg
    case 'x'
        sliceAxe = 1;
    case 'y'
        sliceAxe = 2;
    case 'z'
        sliceAxe = 3;
    otherwise
        sliceAxe = 2;
end
sliceValue = str2double(sliceStrg(3:end));

ratioWidth = 0.05;
widthSliceHalf = ratioWidth*(max(deltaQ(sliceAxe,:)) - min(deltaQ(sliceAxe,:)))/2;
iSlice = find((deltaQ(sliceAxe,:)>(sliceValue-widthSliceHalf))&(deltaQ(sliceAxe,:)<(sliceValue+widthSliceHalf)));

hold on
plot3(deltaQ(1,iSlice),deltaQ(2,iSlice),deltaQ(3,iSlice),'r*');

axePlot2d = 1:3;
axePlot2d(sliceAxe) = [];
figure('Name','ASM slice')
plot(deltaQ(axePlot2d(1),iSlice),deltaQ(axePlot2d(2),iSlice),'ko');
        