function ASM(q,index)
%%
% ASM(q)
%
% Display the Acceleration Surface Method for the data 'q' given in
% argument. index is a matrix containing the indice between which the
% acceleration surface is computed. Set one of the index to 0 to compute
% the AS between the dof and the wall

%%

ratioWidth = 0.05; %ratio of the width of the slice
colorSlice = ['bx'; 'gx'; 'rx'; 'cx'; 'mx'; 'yx'];
% q = rand(2,1000,3);

%% data preparation
sizeQ = size(q);
deltaQ = zeros(3,sizeQ(2));
testIndex = find(index==0,1);
if isempty(testIndex);
    deltaQ(1,:) = q(index(1),:,1) - q(index(2),:,1);
    deltaQ(2,:) = q(index(1),:,2) - q(index(2),:,2);
else
    index(testIndex) = [];
    deltaQ(1,:) = q(index(1),:,1);
    deltaQ(2,:) = q(index(1),:,2);
end    
deltaQ(3,:) = -q(1,:,3);
    
% peut etre changer, fct de ce que renvois le prof

%% ASM 3D plot
fig3d = figure('Name','ASM 3D');
plot3(deltaQ(1,:),deltaQ(2,:),deltaQ(3,:),'ko');
xlabel('x: displacement');
ylabel('y: velocity');
zlabel('z: acceleration');

%% Slice
numberSlice = 1;
promp = sprintf('What slice do you want? axes-value (ex: x-0.5) or no \n');
sliceStrg = input(promp,'s');
while ~strcmpi(sliceStrg,'no')
    % axe
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
    
    % value
    sliceValue = str2double(sliceStrg(3:end));
    widthSliceHalf = ratioWidth*(max(deltaQ(sliceAxe,:)) - min(deltaQ(sliceAxe,:)))/2;
    
    % find indice in deltaQ that are in the slice
    iSlice = find((deltaQ(sliceAxe,:)>(sliceValue-widthSliceHalf))&(deltaQ(sliceAxe,:)<(sliceValue+widthSliceHalf)));
    
    % plot
    figure(fig3d);
    hold on
    plot3(deltaQ(1,iSlice),deltaQ(2,iSlice),deltaQ(3,iSlice),colorSlice(mod(numberSlice,6),:));

    axePlot2d = 1:3;
    axePlot2d(sliceAxe) = [];
    axeName = {'Displacement';'Velocity';'Acceleration'};
    fig2d = figure('Name','ASM slice');
    plot(deltaQ(axePlot2d(1),iSlice),deltaQ(axePlot2d(2),iSlice),'ko');
    titleStrg = sprintf('Slice number %i', numberSlice);
    title(titleStrg);
    xlabel(axeName{axePlot2d(1)});
    ylabel(axeName{axePlot2d(2)});
    
    numberSlice = numberSlice + 1;
    sliceStrg = input(promp,'s');
end
end
        