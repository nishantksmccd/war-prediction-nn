function [loss, grad] = bce_loss(y_true, y_pred, pos_weight)
    arguments
        y_true
        y_pred
        pos_weight = 50                              % rare war event
    end

    eps_val = 1e-12;
    y_pred = min(max(y_pred, eps_val), 1 - eps_val); % to avoid log(0)

    weights = y_true * pos_weight .* (1 - y_true);

    loss = -mean(weights .* (y_true .* log(y_pred) + (1 - y_true) .* ...
        log(1 - y_pred)));

    grad = weights .* (y_pred - y_true) ./ (y_pred .* (1 - y_pred) + ...
        eps_val);