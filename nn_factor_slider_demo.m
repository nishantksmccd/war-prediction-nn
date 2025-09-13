function nn_factor_slider_demo
    % Interactive sliders for 12 conflict-driving factors
    % Each factor has a weight you can adjust with a slider.
    % A sigmoid maps the weighted sum into a war likelihood (0–1).

    % Example dyad feature vector (values between 0 and 1)
    % [Territory, Contiguity, Trade, RegimeDiff, BothDemo, 
    %  MilExpRatio, RelPowerChange, Alliance, PastDisputes, 
    %  EconShock, ResourceRents, LeaderTurnover]
    x = [1 1 0.3 0.7 0 0.4 0.2 1 0.5 0 0.2 1]; 

    factorNames = { ...
        'Territorial Dispute', ...
        'Contiguity', ...
        'Trade Dependence', ...
        'Regime Difference', ...
        'Both Democracies', ...
        'Military Expenditure Ratio', ...
        'Relative Power Change', ...
        'Alliance', ...
        'Past Disputes', ...
        'Economic Shock', ...
        'Resource Rents', ...
        'Leader Turnover'};

    nFactors = numel(factorNames);

    % Create figure
    f = uifigure('Name','Conflict Factor Weight Tuner','Position',[100 100 800 600]);

    % Output label
    outLbl = uilabel(f,'Position',[100 550 400 30], ...
        'Text','Predicted War Likelihood: 0.00%','FontSize',14);

    % Sliders
    sliders = gobjects(nFactors,1);
    labels = gobjects(nFactors,1);
    for i = 1:nFactors
        sliders(i) = uislider(f, ...
            'Position',[150 500-(i-1)*40 300 3], ...
            'Limits',[-3 3], ...   % weight range
            'Value',0.5);          % initial weight
        labels(i) = uilabel(f, ...
            'Position',[470 495-(i-1)*40 250 20], ...
            'Text',factorNames{i});
    end

    % Bias slider
    biasSlider = uislider(f,'Position',[150 40 300 3],'Limits',[-3 3],'Value',0);
    biasLbl = uilabel(f,'Position',[470 35 200 20],'Text','Bias');

    % Update function
    function updateOutput(~,~)
        W = zeros(1,nFactors);
        for j = 1:nFactors
            W(j) = sliders(j).Value;
        end
        b = biasSlider.Value;

        % Forward pass: linear combination + sigmoid
        z = sum(x .* W) + b;
        output = sigmoid(z);

        outLbl.Text = sprintf('Predicted War Likelihood: %.2f%%', output*100);
    end

    % Add listeners
    for i = 1:nFactors
        addlistener(sliders(i),'ValueChanged',@updateOutput);
    end
    addlistener(biasSlider,'ValueChanged',@updateOutput);

    % Activation
    function y = sigmoid(z)
        y = 1 ./ (1 + exp(-z));
    end

    % Initial update
    updateOutput();
end

