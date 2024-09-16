data = csvread("archive\features_raw.csv", 1, 0);
disp(size(data)); % Display the size of the loaded data

% Adjust epoch length or number of samples
num_samples = size(data, 1);
epoch_length = 100; 
num_epochs = floor(num_samples / epoch_length);

if num_epochs == 0
    disp('Error: Insufficient samples for given epoch length.');
else
    eeg_data = data(1:num_epochs*epoch_length, :);

    % Segment EEG data into epochs
    epochs = reshape(eeg_data, epoch_length, [], size(eeg_data, 2));

    % Define start and end indices of the baseline window
    start_sample = 1; 
    baseline_window_length = 100; % Adjust this value according to your baseline window length
    end_sample = start_sample + baseline_window_length - 1; % Calculate the ending sample index

    % Define baseline window (start and end samples)
    baseline_window = [start_sample, end_sample]; 
    % Apply baseline correction
    for i = 1:size(epochs, 3) % Loop over channels
        baseline = mean(epochs(baseline_window(1):baseline_window(2), :, i), 1);
        epochs(:, :, i) = epochs(:, :, i) - baseline;
    end

    % Check number of epochs
    disp(['Number of epochs: ', num2str(num_epochs)]);

    % Plot example epoch for each channel
    epoch_index = 1; % Change this to visualize different epochs
    if epoch_index <= num_epochs
        num_channels = size(epochs, 3);
        num_rows = ceil(num_channels / 4); % Adjust the number of columns as needed
        figure('Position', [200, 200, 800, 600]); % Adjust figure size
        for i = 1:num_channels % Loop over channels
            subplot(num_rows, 4, i);
            plot(epochs(:, epoch_index, i));
            xlabel('Time (samples)');
            ylabel('Amplitude');
            title(['Channel ', num2str(i)]);
        end
        sgtitle(['Epoch ', num2str(epoch_index)]);
    else
        disp('Epoch index exceeds the number of epochs.');
    end
end

% Compute connectivity matrix (correlation)
connectivity_matrix = zeros(size(epochs, 3), size(epochs, 3)); % Initialize connectivity matrix
for i = 1:size(epochs, 3) % Loop over channels
    for j = 1:size(epochs, 3) % Loop over channels
        if i ~= j % Exclude self-connectivity
            % Compute correlation between channels i and j
            correlation_measure = corrcoef(epochs(:,:,i)', epochs(:,:,j)'); % Transpose to match dimensions
            connectivity_measure = correlation_measure(1, 2); % Extract correlation coefficient
            connectivity_matrix(i, j) = connectivity_measure;
        end
    end
end

% Visualize connectivity matrix
figure;
imagesc(connectivity_matrix); % Plot connectivity matrix as an image
colorbar; % Add colorbar
xlabel('Channel');
ylabel('Channel');
title('Connectivity Matrix');

% Threshold the connectivity matrix to create an adjacency matrix
threshold = 0.5; % Adjust the threshold as needed
adjacency_matrix = connectivity_matrix > threshold;

% Create a graph from the adjacency matrix
G = graph(adjacency_matrix);

% Plot the brain functional graph
figure;
plot(G, 'Layout', 'force', 'MarkerSize', 6, 'EdgeAlpha', 0.7);
title('Brain Functional Graph');

