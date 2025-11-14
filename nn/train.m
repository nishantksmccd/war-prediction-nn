function [acc, losses, w1, w2] = train(x, Y, w1, w2, alpha, epoch)
    arguments
        x
        Y
        w1
        w2
        alpha = 0.01
        epoch = 10
    end

    acc = [];
    losses = [];

    whos x;
    whos Y;

    for j = 1:epoch
        l = [];
        for i = 1:size(x, 1)
            out = feedforward(x(i), w1, w2);
            l = [l, bce_loss(out, Y(i, :))];
            [w1, w2] = back_prop(x(i, :)', Y(round(i), :)', w1, w2, alpha);
        end
        y_hat = feedforward(x(i, :), w1, w2) >= 0.5;  % threshold 0.5
        epoch_acc = mean(y_hat == Y(i, :)) * 100;
        epoch_loss = sum(l) / length(x);

        % visual separator
        fprintf('epochs: %d ======== acc: %.2f%%\n', j, epoch_acc);

        acc = [acc, epoch_acc];
        losses = [losses, epoch_loss];
    end