function matrix = generate_weights(x, y)
    rng(0);                           % reproducibility
    matrix = rand(x, y)* sqrt(1 / y); % xavier initialization