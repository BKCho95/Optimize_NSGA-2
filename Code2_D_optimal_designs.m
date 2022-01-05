%% D-Optimal Designs %%
clc; clear all; close all; warning off;


%% --------- Selection of input values (User Define) --------- %%
nfactors = 3;   % 설계변수 개수 정의
nruns = 20;   % 실험 횟수 정의
bounds = [50 5 15; 150 60 30];   % 설계변수 범위 정의
% ---------------------------------------------------------------------- %


%% Calculation
[D_optimal_Results,X] = rowexch(nfactors,nruns,'quadratic','bounds',bounds,'tries',10)