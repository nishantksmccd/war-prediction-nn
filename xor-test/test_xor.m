clc; clear;

[X, Y] = xor_data(); 

load('xor_weights.mat', 'w1_trained', 'w2_trained');

w1 = w1_trained;
w2 = w2_trained;

fprintf('Input  | True | Predicted\n');
fprintf('--------------------------\n');

for i = 1:size(X, 1)
    x_i = X(i, :)';        
    y_true = Y(i);
    y_pred = feedforward(x_i, w1, w2);
    fprintf('%d %d |   %d |   %.4f\n', x_i(1), x_i(2), y_true, y_pred);
end
