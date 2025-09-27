function s = loss(out, Y) % calculate loss using mean squared error
    out_col = out(:);
    Y_col = Y(:);
    s = mean((out_col - Y_col).^2);
