function analyze_svd(w1_trained)
    %  analyze_svd.m
    %  Analyze singular values and dominant feature directions of W1
    %  from trained neural network.

    W1 = w1_trained;

    countries = readtable('utf8-country_data_new.csv');
    countries.Country = strtrim(countries.Country);

    % Remove the country column
    base_features = countries.Properties.VariableNames(2:end);
    feature_names_A = strcat("A_", base_features);
    feature_names_B = strcat("B_", base_features);
    input_features = [feature_names_A, feature_names_B];

    num_inputs = size(W1, 2);
    if num_inputs ~= numel(input_features)
        warning(['Feature name count (%d) does not match W1' ...
            ' columns (%d).'], numel(input_features), num_inputs);
        input_features = pad_features(input_features, num_inputs);
    end

    % SVD
    [U, S, V] = svd(W1);

    singular_values = diag(S);
    fprintf('\n=== SVD Analysis of W1 ===\n');
    fprintf('Hidden neurons: %d\n', size(W1, 1));
    fprintf('Input features: %d\n', size(W1, 2));
    fprintf('Matrix rank: %d\n', rank(W1, 1e-10));
    fprintf('Top 10 singular values of top node:\n');
    disp(singular_values(1:min(10, numel(singular_values))));

    % plot
    figure;
    plot(singular_values, 'o-', 'LineWidth', 1.5);
    xlabel('Index');
    ylabel('Singular Value');
    title('Singular Values of W1');
    grid on;

    % attempt to identify
    [~, top_idx] = max(singular_values);
    top_vector = V(:, top_idx);

    % ranks features
    [~, sorted_idx] = sort(abs(top_vector), 'descend');

    fprintf('\nTop 10 contributing features for singular value %.4f:\n', ...
        singular_values(top_idx));
    for j = 1:min(10, numel(sorted_idx))
        fprintf('  %s (%.4f)\n', input_features(sorted_idx(j)), top_vector(sorted_idx(j)));
    end

    fprintf('\nAnalysis complete.\n');
end


% equalizes/standardizes all features
function adjusted = pad_features(features, target_len)
    if numel(features) < target_len
        extra = "Feature_" + string(1:(target_len - numel(features)));
        adjusted = [features, extra];
    else
        adjusted = features(1:target_len);
    end
end
