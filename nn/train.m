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
            % debug script
            disp(i)
            disp(size(Y))
            disp(Y(i, :))
            % end debug script
            l = [l, loss(out, Y(i, :))];
            [w1, w2] = back_prop(x(i, :)', Y(round(i), :)', w1, w2, alpha);
        end
        epoch_loss = sum(l) / length(x);
        epoch_acc = (1 - epoch_loss) * 100;

        % visual separator
        fprintf('epochs: %d ======== acc: %.2f%%\n', j, epoch_acc);

        acc = [acc, epoch_acc];
        losses = [losses, epoch_loss];
    end
end