% only sigmoid needs to be defined, tanh is built in

function output = sigmoid(z)
    z = max(min(z, 50), -50);
    output = 1 ./ (1 + exp(-z));