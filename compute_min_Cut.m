data = csvread("C:\Users\araku\OneDrive\Desktop\BFG\archive\features_raw.csv", 1, 0); 

% Create adjacency matrix
adjacency_matrix = corrcoef(data);
minCut = StoerWagner(adjacency_matrix);
disp(['Minimum cut weight: ' num2str(minCut)]);