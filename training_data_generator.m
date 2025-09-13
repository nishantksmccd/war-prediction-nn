function [Xtrain, Ytrain] = training_data_generator()
% TRAINING_DATA_GENERATOR  Build synthetic dataset of country pairs.
%   [Xtrain, Ytrain] = training_data_generator()
%   returns a matrix Xtrain (N x 24) and label vector Ytrain (N x 1).
%   Each row corresponds to the concatenated features of two countries,
%   with Ytrain = 1 meaning "likely war" and 0 = "likely peace".

    % Load country data
    [countries, X] = country_data();
    nCountries = length(countries);

    % Preallocate (all unique pairs)
    nPairs = nchoosek(nCountries, 2);
    Xtrain = zeros(nPairs, 24);
    Ytrain = zeros(nPairs, 1);

    pairIdx = 1;

    for i = 1:nCountries-1
        for j = i+1:nCountries
            % Extract two feature vectors
            x1 = X(i, :);
            x2 = X(j, :);

            % Concatenate into one row
            Xtrain(pairIdx, :) = [x1, x2];

            % --- Compute heuristic war score ---
            score = 0;

            % Territorial disputes & historical conflict
            score = score + 0.4 * (x1(8) * x2(8));  % geographic disputes
            score = score + 0.3 * (x1(7) * x2(7));  % historical conflict

            % Nationalism + resource pressure
            score = score + 0.2 * (x1(9) * x2(9));
            score = score + 0.2 * (x1(12) * x2(12));

            % Opposing alliances
            if (x1(5) > 0.7 && x2(6) > 0.7) || (x1(6) > 0.7 && x2(5) > 0.7)
                score = score + 0.4;
            end

            % Peaceful factors (subtract)
            if (x1(5) > 0.7 && x2(5) > 0.7) || (x1(6) > 0.7 && x2(6) > 0.7)
                score = score - 0.3;
            end
            if (x1(10) > 0.7 && x2(10) > 0.7)  % both democratic
                score = score - 0.3;
            end
            if (x1(1) > 0.7 && x2(1) > 0.7)  % both high GDP
                score = score - 0.2;
            end

            % Normalize and assign label
            prob = min(max(score, 0), 1);   % clamp to [0,1]
            Ytrain(pairIdx) = double(prob > 0.5);  % threshold

            pairIdx = pairIdx + 1;
        end
    end
end
