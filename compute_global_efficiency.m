data = csvread("C:\Users\araku\OneDrive\Desktop\BFG\archive\features_raw.csv", 1, 0); 

% Create adjacency matrix
adjacency_matrix = corrcoef(data);

% Calculate global efficiency
Global_efficiency = global_efficiency(adjacency_matrix);

% Display result
disp(['Global Efficiency: ' num2str(Global_efficiency)]);
