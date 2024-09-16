function maximal_cliques = maximalCliques(G)
    % Initialize maximal cliques as an empty cell array
    maximal_cliques = {};

    % Define a function to find maximal cliques recursively
    function findMaximalCliques(R, P, X)
        if isempty(P) && isempty(X)
            % R is a maximal clique, add it to the list
            maximal_cliques{end+1} = R;
        else
            % Choose a pivot node u from P or X
            pivot = union(P, X);
            u = pivot(1);

            % Iterate over vertices in P \ neighbors(u)
            P_minus_neighbors = setdiff(P, neighbors(G, u));
            for v = P_minus_neighbors
                findMaximalCliques(union(R, v), intersect(P, neighbors(G, v)), intersect(X, neighbors(G, v)));
                P = setdiff(P, v);
                X = union(X, v);
            end
        end
    end

    % Start the recursive search from an empty set R, all vertices as P, and an empty set X
    findMaximalCliques([], 1:numnodes(G), []);

    % Return the list of maximal cliques
end
