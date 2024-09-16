function shortest_paths = floyd_warshall(adjacency_matrix)
    num_nodes = size(adjacency_matrix, 1);
    shortest_paths = adjacency_matrix;
    shortest_paths(shortest_paths == 0) = Inf; % Set zero distances to Inf
    
    % Apply Floyd-Warshall algorithm
    for k = 1:num_nodes
        for i = 1:num_nodes
            for j = 1:num_nodes
                shortest_paths(i, j) = min(shortest_paths(i, j), shortest_paths(i, k) + shortest_paths(k, j));
            end
        end
    end
end