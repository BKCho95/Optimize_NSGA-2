function f = crowding_distance(x,problem)
% This function calculates the crowding distance


[N,M] = size(x);
switch problem
    case 1
        M = 2; % M is the number of objectives.
        V = 4; % V is the number of decision variables.
    case 2
        M = 3;
        V = 12;
end

% Crowding distance for each front
for i = 1 : length(F(front).f)
    y(i,:) = x(F(front).f(i),:);
end
for i = 1 : M
    [sorted(i).individual,sorted(i).index] = sort(y(:,V + i));
    distance(sorted(i).index(1)).individual = Inf;
    distance(sorted(i).index(length(sorted(i).index))).individual = Inf;
end

[num,len] = size(y);
% Initialize all the distance of individuals as zero.
for i = 1 : M
    for j = 2 : num - 1
        distance(j).individual = 0;
    end
    objective(i).range = ...
                sorted(i).individual(length(sorted(i).individual)) - ...
                sorted(i).individual(1);
        % Maximum and minimum objectives value for the ith objective
end 
% Caluclate the crowding distance for front one.
for i = 1 : M
    for j = 2 : num - 1
        distance(j).individual = distance(j).individual + ...
            (sorted(i).individual(j + 1) - sorted(i).individual(j - 1))/...
            objective(i).range;
        y(sorted(i).index(j),M + V + 2) = distance(j).individual;
    end
end
