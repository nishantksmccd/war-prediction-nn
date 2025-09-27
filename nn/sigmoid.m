% only sigmoid needs to be defined, tanh is built in

function output = sigmoid(z)
    output = 1 ./ (1 + exp(z));