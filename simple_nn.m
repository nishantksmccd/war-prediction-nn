function y = simple_nn(x1, x2, params)
% SIMPLE_NN  Forward pass for a 2-country war likelihood neural net.
%
%   y = simple_nn(x1, x2, params)
%
%   Inputs:
%     x1, x2 - 1x12 numeric feature vectors (row vectors) for two countries
%     params - struct with fields W1, b1, W2, b2
%
%   Output:
%     y - scalar value between 0 and 1 (predicted war likelihood)

    % --- Concatenate into single input vector ---
    x = [x1, x2]';   % (24x1 column vector if 12 features each)

    % --- Unpack parameters ---
    W1 = params.W1;  b1 = params.b1;
    W2 = params.W2;  b2 = params.b2;

    % --- Forward pass ---
    z1 = W1 * x + b1;         % hidden layer pre-activation
    a1 = tanh(z1);            % hidden layer activation
    z2 = W2 * a1 + b2;        % output layer pre-activation
    y  = 1 ./ (1 + exp(-z2)); % sigmoid → probability (0 to 1)
end
