clear; clc;

% load formatted data
load('X_train.mat');
load('y_train.mat');

% casting
X = double(X_train);
y = double(y_train);

% transpose the output matrix (y)
y = y';

% slow learning rate with 100 epochs
alpha = 0.01;
epochs = 99;
input_size = size(X, 2);                         % number of features (152)
hidden_size = 32;                                % 64 hidden neurons
output_size = 1;                                 % 1 output
w1 = generate_weights(hidden_size, input_size);
w2 = generate_weights(output_size, hidden_size);

if size(X, 1) ~= size(y, 1)
    error(['ERROR in DATA FORMATTING: Number of country pairs is' ...
        '         not equal to number of test cases!']);
end

% train
[acc, losses, w1_trained, w2_trained] = train(X, y, w1, w2, alpha, epochs);
figure;
plot(1:epochs, losses);
title('Training Loss per Epoch');
xlabel('Epoch');
ylabel('Loss');

z1_train = X * w1_trained';
a1_train = sigmoid(z1_train);
z2_train = a1_train * w2_trained';
a2_train = sigmoid(z2_train);
preds_train = a2_train >= 0.5;
fprintf('Train mean prediction (prob): %.4f\n', mean(a2_train(:)));
fprintf('Train positive predictions: %d / %d\n', sum(preds_train), ...
    numel(preds_train));

% f1 calculation
threshold = 0.53;
y_pred_train = a2_train >= threshold;
y_true_train = y;

tp = sum((y_pred_train == 1) & (y_true_train == 1));
fp = sum((y_pred_train == 1) & (y_true_train == 0));
fn = sum((y_pred_train == 0) & (y_true_train == 1));
eps_val = 1e-12;

precision = tp / (tp + fp + eps_val);
recall = tp / (tp + fn + eps_val);

f1_score = f1(precision, recall, eps);

fprintf('---------------------------\n');
fprintf('final f1 score: %.2f\n', f1_score);

% divide screen for test
fprintf('---------------------------\n');
% test
main_test(w1_trained, w2_trained, epochs);

fprintf('Number of Independent Factors: %d\n', rank(w1, 1e-10));

% SVD of W1
[U1, S1, V1] = svd(w1_trained);

fprintf('For SVD analysis, run "analyze_svd" in the command line.\n');

if rank(w2) == 0
    fprintf('ERROR in TRAINING: Weights are all zero or NaN.\n');
end