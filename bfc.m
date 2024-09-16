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

% Plot graph
figure;
h = plot(G, 'Layout', 'force', 'EdgeColor', [0.7 0.7 0.7], 'EdgeAlpha', 0.5, 'NodeColor', 'b', 'NodeLabel', G.Nodes.Name);
title('Brain Functional Network');
