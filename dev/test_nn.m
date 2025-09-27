clear;
clc;

x = rand(100, 1);
y = rand(100, 1);

alpha = 0.01;
epochs = 100;
input_size = size(x, 2);
hidden_size = 10;
output_size = 1;
w1 = generate_weights(hidden_size, input_size);
w2 = generate_weights(output_size, hidden_size);

if size(x, 1) ~= size(y, 1)
    error('The number of examples in x and y must be the same.');
end

[acc, losses, w1_trained, w2_trained] = train(x, y, w1, w2, alpha, epochs);
figure;
plot(1:epochs, losses);
title('Training Loss per Epoch');
xlabel('Epoch');
ylabel('Loss');
