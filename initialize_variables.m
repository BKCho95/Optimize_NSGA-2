function f = initialize_variables(N,problem)

% function f = initialize_variables(N,problem)
% N - Population size
% problem - takes integer values 1 and 2 where,
%           '1' for MOP1
%           '2' for MOP2
%
% This function initializes the population with N individuals and each
% individual having M decision variables based on the selected problem. 
% M = 6 for problem MOP1 and M = 12 for problem MOP2. The objective space
% for MOP1 is 2 dimensional while for MOP2 is 3 dimensional.


% Both the MOP's has 0 to 1 as its range for all the decision variables. 
% N = 100; problem = 1;

Bpn_Input = load('Model1_range.txt') ;

i_min = min(Bpn_Input) ;
i_max = max(Bpn_Input) ;

switch problem
    case 1
        M = 4; % M is the number of variables.
        K = 6; % K is the number of objectives + the number of decision variables.
    case 2
        M = 12;
        K = 15;
end

for i = 1 : N                                  % NÀº Number of Population
    % Initialize the decision variables
    for j = 1 : M
        f(i,j) = i_min(j) + (i_max(j) - i_min(j))*rand(1);
    end
    
    % Evaluate the objective function
     f(i,M + 1: K) = evaluate_objective(f(i,:),problem);
end
