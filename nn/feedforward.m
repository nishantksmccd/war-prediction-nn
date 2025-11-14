function a2 = feedforward(x, w1, w2) % forward propagation
    z1 = w1 .* x;
    a1 = sigmoid(z1);
    z2 = w2 * a1;
    a2 = sigmoid(z2);