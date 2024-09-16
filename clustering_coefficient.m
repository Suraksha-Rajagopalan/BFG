function cc = clustering_coefficient(adjacency_matrix)
    % Calculate the number of nodes in the graph
    num_nodes = size(adjacency_matrix, 1);
    
    % Initialize an array to store the clustering coefficient of each node
    cc = zeros(num_nodes, 1);
    
    % Iterate over each node
    for i = 1:num_nodes
        % Find neighbors of the node
        neighbors = find(adjacency_matrix(i, :) > 0);
        num_neighbors = length(neighbors);
        
        % If a node has fewer than two neighbors, clustering coefficient is undefined (set to 0)
        if num_neighbors < 2
            continue;
        end
        
        % Count the number of edges between neighbors
        num_edges = sum(adjacency_matrix(neighbors, neighbors), 'all') / 2;
        
        % Compute the clustering coefficient for the node
        cc(i) = 2 * num_edges / (num_neighbors * (num_neighbors - 1));
    end
    
    % Compute the average clustering coefficient of the graph
    cc = mean(cc);
end
