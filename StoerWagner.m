function minCut = StoerWagner(adjacency_matrix)
    n = size(adjacency_matrix, 1);
    minCut = inf;
    best_partition = [];
    
    for phase = 1:n-1
        nodes = 1:n;
        weight = zeros(1, n);
        is_active = true(1, n);
        for i = 1:n-phase+1
            s = nodes(i);
            t = s;
            for j = i:n
                if is_active(nodes(j))
                    if weight(nodes(j)) > weight(t)
                        t = nodes(j);
                    end
                end
            end
            if i < n-phase+1
                weight(t) = weight(t) + adjacency_matrix(s, t);
                for j = 1:n
                    if is_active(j)
                        adjacency_matrix(t, j) = adjacency_matrix(t, j) + adjacency_matrix(s, j);
                        adjacency_matrix(j, t) = adjacency_matrix(t, j);
                    end
                end
                is_active(t) = false;
            elseif phase < n-1
                if weight(t) < minCut
                    minCut = weight(t);
                    best_partition = nodes(is_active);
                end
                for j = 1:n
                    adjacency_matrix(s, j) = adjacency_matrix(s, j) + adjacency_matrix(t, j);
                    adjacency_matrix(j, s) = adjacency_matrix(s, j);
                end
            end
        end
    end
end
