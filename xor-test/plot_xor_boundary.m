% Load trained weights
load('xor_weights.mat', 'w1_trained', 'w2_trained');
w1 = w1_trained;
w2 = w2_trained;

% Grid resolution
res = 0.01;  % smaller = smoother
[x1_grid, x2_grid] = meshgrid(0:res:1, 0:res:1);

% Preallocate predictions
% chatGPT generated for showing decision boundary

pred_grid = zeros(size(x1_grid));

% Evaluate network at each grid point
for i = 1:size(x1_grid, 1)
    for j = 1:size(x1_grid, 2)
        x_input = [x1_grid(i,j); x2_grid(i,j)];  % column vector
        pred_grid(i,j) = feedforward(x_input, w1, w2);
    end
end

figure;
contourf(x1_grid, x2_grid, pred_grid, [0 0.5 1], 'LineColor', 'k');
colormap([1 0.7 0.7; 0.7 0.7 1]);  % red for 0, blue for 1
hold on;

% Plot original XOR points
[X, Y] = xor_data();
scatter(X(Y==0,1), X(Y==0,2), 100, 'r', 'filled');  % class 0
scatter(X(Y==1,1), X(Y==1,2), 100, 'b', 'filled');  % class 1

xlabel('Input 1');
ylabel('Input 2');
title('Decision Boundary for XOR Network');
legend('Class 0 region','Class 1 region','Class 0 points','Class 1 points');
axis([0 1 0 1]);
grid on;
