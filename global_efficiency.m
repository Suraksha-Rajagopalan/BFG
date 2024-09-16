function ge = global_efficiency(adjacency_matrix)
    n = size(adjacency_matrix, 1);
    ge = 0;
    for i = 1:n
        for j = 1:n
            if i ~= j && adjacency_matrix(i, j) ~= 0
                ge = ge + (1 / adjacency_matrix(i, j));
            end
        end
    end
    ge = ge / (n*(n-1));
end