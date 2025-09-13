function params = init_params(inputSize, hiddenSize, outputSize)
% INIT_PARAMS  Initialize neural network weights and biases
%   params = init_params(inputSize, hiddenSize, outputSize)
%
%   Returns a struct with fields:
%     .W1  (hiddenSize x inputSize)
%     .b1  (hiddenSize x 1)
%     .W2  (outputSize x hiddenSize)
%     .b2  (outputSize x 1)
%
%   Example:
%     params = init_params(24, 16, 1);

    if nargin < 3
        outputSize = 1; % default to binary classification
    end

    rng('default'); % for reproducibility

    % He/Xavier initialization for stability
    scaleW1 = sqrt(2 / (inputSize + hiddenSize));
    scaleW2 = sqrt(2 / (hiddenSize + max(1, outputSize)));

    params.W1 = randn(hiddenSize, inputSize) * scaleW1;
    params.b1 = zeros(hiddenSize, 1);

    params.W2 = randn(outputSize, hiddenSize) * scaleW2;
    params.b2 = zeros(outputSize, 1);
end
