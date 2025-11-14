function main_test(w1_trained, w2_trained, epoch)
    best_thresh = 0.53;

    % Load test data
    load('X_test.mat');
    load('y_test.mat');
    X_test = double(X_test);
    y_test = double(y_test);

    % Forward pass
    z1 = X_test * w1_trained';
    a1 = sigmoid(z1);
    z2 = a1 * w2_trained';
    a2 = sigmoid(z2);


    % Compute predictions and accuracy
    preds = a2 >= best_thresh;
    acc = mean(preds == y_test');

    y_pred = preds;
    y_true = y_test';
    eps = 1e-10;
    
    tp = sum((y_pred == 1) & (y_true == 1));
    fp = sum((y_pred == 1) & (y_true == 0));
    fn = sum((y_pred == 0) & (y_true == 1));
    
    precision = tp / (tp + fp + epoch);
    recall = tp / (tp + fn + epoch);
    f1 = 2 * (precision * recall) / (precision + recall + eps);
    
    fprintf('epochs: %d ======== F1: %.2f (test)\n', epoch, f1);

    % After computing preds and y_test'
    y_true = double(y_true(:));
    preds = double(preds(:));
    confusionchart(y_true, preds);
    fprintf('Mean prediction: %.4f\n', mean(a2(:)));

    fprintf('Test mean prediction (prob): %.4f\n', mean(a2(:)));
    % fprintf('Test positive predictions: %d / %d\n', sum(preds), numel(preds));

    acc = mean(preds == y_true);
    fprintf('---------------------------\n');
    fprintf('TEST ACCURACY: %.2f percent\n', acc * 100);
    fprintf('---------------------------\n');
end