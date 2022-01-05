%% Central Composite Design %%
clc; clear all; close all; warning off;


%% --------- Selection of input values (User Define) --------- %%
nfactors = 3;   % 설계변수 개수 정의
type = 'circumscribed';   % CCD 종류 정의
% ---------------------------------------------------------------------- %


%% Calculation
CCD_Results = ccdesign(nfactors,'type',type)


%% Plot
plot(CCD_Results(:,1),CCD_Results(:,2),'ro','MarkerFaceColor','b')
X = [1 -1 -1 -1; 1 1 1 -1]; Y = [-1 -1 1 -1; 1 -1 1 1]; line(X,Y,'Color','b')
axis square equal