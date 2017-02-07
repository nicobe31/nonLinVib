%% This code is the code of the part 3

%% Calcul of matrix Ks and Ms

% function Part3(Samcef)

close all

run Dimensions
run Geometry

nElementT = 0;
for i = 1 : 45
    nElementT = nElementT + element(i,5);
end

nodeList = zeros(nElementT,3);

basic_dofs = zeros(29,6);

for i = 1:29
    basic_dofs(i,:) = [(i-1)*6+1 (i-1)*6+2 (i-1)*6+3 (i-1)*6+4 (i-1)*6+5 (i-1)*6+6];
end

nBeamG = 12; % number of big beams
nBeamM = 29; % number of middel beams
nBeamP = 4; % number of little beam

for i = 1:45
    dofList(((i-1)*element(i,5))+1,:) = basic_dofs(element(i,1),:);
    nodeList(((i-1)*element(i,5))+1,:) = Node(element(i,1),:);
    
    for j = 1:element(i,5)-2
        dofList((element(i,5)*(i-1))+1+j,:) = (29*6+((i-1)*(element(i,5)-2)+j-1)*6)+(1:6);
        nodeList((element(i,5)*(i-1))+1+j,:) = Node(element(i,1),:) + ((Node(element(i,2),:)-Node(element(i,1),:))./(element(i,5)-1)*j);
    end
    
    dofList((i*element(i,5)),:) = basic_dofs(element(i,2),:);
    nodeList((i*element(i,5)),:) = Node(element(i,2),:);
end

for i = 1:45
    for j = 1:element(i,5)-1
        Kel(:,:,(i-1)*(element(i,5)-1)+j) = matriceRaideur(element(i,3), element(i,4), nodeList((i-1)*element(i,5)+j,:), nodeList((i-1)*element(i,5)+(j+1),:));
        Mel(:,:,(i-1)*(element(i,5)-1)+j) = matriceMasse(element(i,3), element(i,4), nodeList((i-1)*element(i,5)+j,:), nodeList((i-1)*element(i,5)+(j+1),:));
    end
end


% Assembly of the structural and mass matrices
nNode = 0;
for i = 1 : 45
    nNode = nNode + element(i,5) - 2;
end
nNode = nNode + 29;

Ks = zeros(nNode*6,nNode*6);
Ms = zeros(nNode*6,nNode*6);

for i = 1:45
    for j = 1:element(i,5)-1
        dofs1 = dofList((i-1)*element(i,5)+j,:);
        dofs2 = dofList((i-1)*element(i,5)+(j+1),:);
        locel = [dofs1 dofs2];
        for k=1:12
            for l=1:12
                Ks(locel(k), locel(l)) = Ks(locel(k), locel(l)) +  Kel(k,l,(i-1)*(element(i,5)-1)+j);
                Ms(locel(k), locel(l)) = Ms(locel(k), locel(l)) +  Mel(k,l,(i-1)*(element(i,5)-1)+j);
            end
        end
    end
end

fixedDof = [10*6+1:10*6+6 11*6+1:11*6+6 12*6+1:12*6+6 13*6+1:13*6+6];

Ks(fixedDof, :) = [];
Ks(:, fixedDof) = [];
Ms(fixedDof, :) = [];
Ms(:, fixedDof) = [];

nb_vp = 10; % nombre de modes propres et valeurs propres à afficher

clear Ms
clear Ks

Ms = [1 0; 0 1]
Ks =[20000 -10000; -10000 20000]
C = [3 -1; -1 3];
[V, D]=eigs(Ks, Ms, 2, 'sm');
w = sqrt(diag(D)); % [rad/s]
f = w /2/pi;

V2 = V;

%% Calcul of parameters

A = zeros(2, 2);
epsR = zeros(2,1);
epsR(:,1) = 0.005;
result = zeros(2,1);
gamma = zeros(2,1);
mu = zeros(2,1);
V2t = V2';
omega = 2*pi;



result = A\epsR;

%C = result(1)*Ks + result(2)*Ms;

%% Codes

run ComparisonStep
run ComparisonSamcef
run FRF