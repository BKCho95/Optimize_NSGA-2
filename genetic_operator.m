function f  = genetic_operator(parent_chromosome,pro,mu,mum);

% This function is utilized to produce offsprings from parent chromosomes.
% The genetic operators corssover and mutation which are carried out with
% slight modifications from the original design. For more information read
% the document enclosed.

[N,M] = size(parent_chromosome);
switch pro
    case 1
        M = 2; % M is the number of objectives.
        V = 4; % V is the number of decision variables.
    case 2
        M = 3;
        V = 12;
end
p = 1;
was_crossover = 0;
was_mutation = 0;
Bpn_Input = load('Model1_range.txt') ;

l_limit = min(Bpn_Input) ;
u_limit = max(Bpn_Input) ;

for i = 1 : N
    if rand(1) < 0.9
        child_1 = [];
        child_2 = [];
        parent_1 = round(N*rand(1));
        if parent_1 < 1
            parent_1 = 1;
        end
        parent_2 = round(N*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end
        while isequal(parent_chromosome(parent_1,:),parent_chromosome(parent_2,:))
            parent_2 = round(N*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
        end
        parent_1 = parent_chromosome(parent_1,:);
        parent_2 = parent_chromosome(parent_2,:);
        for j = 1 : V
            % SBX (Simulated Binary Crossover)
            % Generate a random number
            u(j) = rand(1);
            if u(j) <= 0.5
                bq(j) = (2*u(j))^(1/(mu+1));
            else
                bq(j) = (1/(2*(1 - u(j))))^(1/(mu+1));
            end
            child_1(j) = ...
                0.5*(((1 + bq(j))*parent_1(j)) + (1 - bq(j))*parent_2(j));
            child_2(j) = ...
                0.5*(((1 - bq(j))*parent_1(j)) + (1 + bq(j))*parent_2(j));
            if child_1(j) > u_limit(j)
                child_1(j) = u_limit(j);
            elseif child_1(j) < l_limit(j)
                child_1(j) = l_limit(j);
            end
            if child_2(j) > u_limit(j)
                child_2(j) = u_limit(j);
            elseif child_2(j) < l_limit(j)
                child_2(j) = l_limit(j);
            end
        end
        child_1(:,V + 1: M + V) = evaluate_objective(child_1,pro);
        child_2(:,V + 1: M + V) = evaluate_objective(child_2,pro);
        was_crossover = 1;
        was_mutation = 0;
    else
        parent_3 = round(N*rand(1));
        if parent_3 < 1
            parent_3 = 1;
        end
        % Make sure that the mutation does not result in variables out of
        % the search space. For both the MOP's the range for decision space
        % is [0,1]. In case different variables have different decision
        % space each variable can be assigned a range.
        child_3 = parent_chromosome(parent_3,:);
        for j = 1 : V
           r(j) = rand(1);
           if r(j) < 0.5
               delta(j) = (2*r(j))^(1/(mum+1)) - 1;
           else
               delta(j) = 1 - (2*(1 - r(j)))^(1/(mum+1));
           end
           child_3(j) = child_3(j) + delta(j);
           if child_3(j) > u_limit(j)
               child_3(j) = u_limit(j);
           elseif child_3(j) < l_limit(j)
               child_3(j) = l_limit(j);
           end
        end
        child_3(:,V + 1: M + V) = evaluate_objective(child_3,pro);
        was_mutation = 1;
        was_crossover = 0;
    end
    if was_crossover
        child(p,:) = child_1;
        child(p+1,:) = child_2;
        was_cossover = 0;
        p = p + 2;
    elseif was_mutation
        child(p,:) = child_3(1,1 : M + V);
        was_mutation = 0;
        p = p + 1;
    end
end
f = child;
