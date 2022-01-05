function f = selection_individuals(chromosome,pool_size,tour_size)

% function selection_individuals(chromosome,pool_size,tour_size) is the
% selection policy for selecting the individuals for the mating pool. The
% selection is based on tournament selection. Argument 'chromosome' is the
% current generation population from which the individuals are selected to 
% form a mating pool of size 'pool_size' after performing tournament 
% selection, with size of the tournament being 'tour_size'. By varying the 
% tournament size the selection pressure can be adjusted.

[pop,variables] = size(chromosome);
rank = variables - 1;
distance = variables;

for i = 1 : pool_size
    for j = 1 : tour_size
        candidate(j) = round(pop*rand(1));
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            while ~isempty(find(candidate(1 : j - 1) == candidate(j)))
                candidate(j) = round(pop*rand(1));
                if candidate(j) == 0
                    candidate(j) = 1;
                end
            end
        end
    end
    for j = 1 : tour_size
        c_obj_rank(j) = chromosome(candidate(j),rank);
        c_obj_distance(j) = chromosome(candidate(j),distance);
    end
    min_candidate = ...
        find(c_obj_rank == min(c_obj_rank));
    if length(min_candidate) ~= 1
        max_candidate = ...
        find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);
        end
        f(i,:) = chromosome(candidate(min_candidate(max_candidate)),:);
    else
        f(i,:) = chromosome(candidate(min_candidate(1)),:);
    end
end
