% focal loss: alternative to MSE built for highly unbalanced sets (unused,
% abandoned for bse_loss.m)

function loss = focal_loss(y_true, y_pred, alpha, gamma)
    arguments
        y_true
        y_pred
        alpha = 2
        gamma = 5
    end

    p_t = y_pred .* y_true + (1 - y_pred) .* (1 - y_true);
    loss = -mean(alpha * (1 - p_t) .^ gamma .* y_true .* log(y_pred + ...
        eps) + (1 - y_true) .* log(1 - y_pred + eps));
end