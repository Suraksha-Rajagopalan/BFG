function local_efficiencies = local_efficiency(adjacency_matrix)
    num_nodes = size(adjacency_matrix, 1);
    local_efficiencies = zeros(num_nodes, 1);
    
    % Compute shortest path lengths between all pairs of nodes using Floyd-Warshall algorithm
    shortest_paths = floyd_warshall(adjacency_matrix);
    
    % Iterate over each node
    for i = 1:num_nodes
        % Find neighbors of the node
        neighbors = find(adjacency_matrix(i, :));
        
        % Compute local efficiency for the node
        if numel(neighbors) > 1
            % Consider only nodes with more than one neighbor
            neighborhood_matrix = adjacency_matrix(neighbors, neighbors);
            % Compute average shortest path length within the neighborhood
            neighborhood_shortest_paths = shortest_paths(neighbors, neighbors);
            neighborhood_shortest_paths(neighborhood_shortest_paths == 0) = Inf; % Replace zero distances with Inf to exclude disconnected nodes
            local_efficiency_i = 1 / mean(neighborhood_shortest_paths(~isinf(neighborhood_shortest_paths))); % Compute local efficiency
            local_efficiencies(i) = local_efficiency_i;
        end
    end
end