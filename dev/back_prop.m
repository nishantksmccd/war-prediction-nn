function [w1, w2] = back_prop(x, y, w1, w2, alpha) % back propaagation

    % hidden layer
	z1 = w1 * x;
	a1 = sigmoid(z1); 
	z2 = w2 * a1;
	a2 = sigmoid(z2);
    disp(size(z2))

    % error in output layer
    d2 = a2 - y;
    d1 = (w2 * d2')' .* (a1 .* (1 - a1));

    % gradient for w1 and w2
    w1_adj = d1 * x';
    w2_adj = d2 * a1';

    % updating parameters for output
    w1 = w1 - (alpha * w1_adj);
    w2 = w2 - (alpha * w2_adj);