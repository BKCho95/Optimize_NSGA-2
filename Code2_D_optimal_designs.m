%% D-Optimal Designs %%
clc; clear all; close all; warning off;


%% --------- Selection of input values (User Define) --------- %%
nfactors = 3;   % ���躯�� ���� ����
nruns = 20;   % ���� Ƚ�� ����
bounds = [50 5 15; 150 60 30];   % ���躯�� ���� ����
% ---------------------------------------------------------------------- %


%% Calculation
[D_optimal_Results,X] = rowexch(nfactors,nruns,'quadratic','bounds',bounds,'tries',10)