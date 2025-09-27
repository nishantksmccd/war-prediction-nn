clc; clear;
[X, Y] = xor_data();  % 4x2 inputs, 4x1 outputs

input_size = size(X, 2);  % 2
hidden_size = 4;
output_size = 1;

w1 = generate_weights(hidden_size, input_size);  % 4x2
w2 = generate_weights(output_size, hidden_size); % 1x4

alpha = 0.1;
epochs = 5000;

[acc, losss, w1_trained, w2_trained] = train(X, Y, w1, w2, alpha, epochs);

figure;
plot(1:epochs, losss, 'LineWidth', 2);
xlabel('Epoch');
ylabel('Loss');
title('XOR Training Loss');

save('xor_weights.mat', 'w1_trained', 'w2_trained');
