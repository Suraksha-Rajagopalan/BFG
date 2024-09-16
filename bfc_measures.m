% Read data from CSV file
data = csvread("C:\Users\araku\OneDrive\Desktop\BFG\archive\features_raw.csv", 1, 0); % Assuming the first row is header

% Define electrode names
electrode_names = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', 'CP1', 'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', 'Fz', 'F4', 'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', 'CP2', 'P4', 'P8', 'PO4', 'O2'};
num_electrodes = length(electrode_names);

% Create adjacency matrix
adjacency_matrix = corrcoef(data);

% Set diagonal elements to zero: Avoiding self loops
adjacency_matrix(1:num_electrodes+1:end) = 0;

% Create graph object
G = graph(adjacency_matrix, electrode_names, 'upper');

% Calculate clustering coefficient
clustering_coefficient = clustering_coefficient(adjacency_matrix);

% Degree Distribution
degrees = degree(G);
degree_distribution = histcounts(degrees, 'BinMethod', 'integers', 'Normalization', 'probability');

% Local Efficiency (assuming you have a function named local_efficiency)
local_efficiencies = local_efficiency(adjacency_matrix);

% Find maximal cliques (assuming you have a function named maximalCliques)
maximal_cliques = maximalCliques(G);

% Find the size of the largest clique
max_clique_size = max(cellfun(@length, maximal_cliques));

% Displaying Results
disp('Clustering Coefficient:');
disp(clustering_coefficient);

disp('Degree Distribution:');
disp(degree_distribution);

disp('Local Efficiency (Mean):');
disp(local_efficiencies);

disp('Max Clique Size:');
disp(max_clique_size);
