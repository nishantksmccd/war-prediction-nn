% Simple Feed-Forward Neural Network in MATLAB
% For predicting war likelihood between two countries

clear; clc; rng(1);

%% Parameters
input_size = 6;    % e.g. 3 features per country -> economy, stability, etc.
hidden_size = 4;   % neurons in hidden layer
output_size = 1;   % war likelihood (0-1)
learning_rate = 0.01;
epochs = 500;

%% Generate sample training data (toy example)
% Features: [countryA_features , countryB_features]
X = rand(100, input_size);   % 100 samples, normalized [0,1]
y = double(rand(100,1) > 0.5); % random 0/1 war outcome

%% Initialize weights
W1 = randn(input_size, hidden_size) * 0.1;
b1 = zeros(1, hidden_size);
W2 = randn(hidden_size, output_size) * 0.1;
b2 = zeros(1, output_size);

%% Activation functions
sigmoid = @(z) 1 ./ (1 + exp(-z));
dsigmoid = @(z) sigmoid(z) .* (1 - sigmoid(z));

%% Training loop
for epoch = 1:epochs
    % Forward pass
    Z1 = X * W1 + b1;       % Hidden layer input
    A1 = sigmoid(Z1);       % Hidden layer output
    Z2 = A1 * W2 + b2;      % Output layer input
    A2 = sigmoid(Z2);       % Prediction (0 to 1)

    % Compute loss (binary cross-entropy)
    loss = -mean(y .* log(A2+1e-8) + (1-y) .* log(1-A2+1e-8));

    % Backpropagation
    dZ2 = A2 - y;                           % Error at output
    dW2 = (A1' * dZ2) / size(X,1);
    db2 = mean(dZ2, 1);

    dA1 = dZ2 * W2';
    dZ1 = dA1 .* dsigmoid(Z1);
    dW1 = (X' * dZ1) / size(X,1);
    db1 = mean(dZ1, 1);

    % Update weights
    W1 = W1 - learning_rate * dW1;
    b1 = b1 - learning_rate * db1;
    W2 = W2 - learning_rate * dW2;
    b2 = b2 - learning_rate * db2;

    % Print progress
    if mod(epoch,50)==0
        fprintf('Epoch %d | Loss: %.4f\n', epoch, loss);
    end
end

%% Test on new data
new_X = rand(1, input_size); % random new pair of countries
hidden = sigmoid(new_X * W1 + b1);
output = sigmoid(hidden * W2 + b2);

fprintf('\nPredicted war likelihood: %.2f%%\n', output*100);
