function [x1, x2] = data_parser(country1, country2)
% DATA_PARSER  Return feature vectors for two countries.
%   [x1, x2] = data_parser('United States','China')
%   loads the country feature matrix and returns the corresponding
%   12-dimensional feature vectors for the selected countries.
%
%   Inputs:
%     country1, country2 - names of two countries (strings)
%   Outputs:
%     x1, x2 - 1x12 feature vectors

    % --- Load country names and feature matrix ---
    [countries, X] = country_data();

    % --- Find indices of requested countries ---
    idx1 = find(strcmpi(countries, country1), 1);
    idx2 = find(strcmpi(countries, country2), 1);

    if isempty(idx1)
        error('Country "%s" not found in dataset.', country1);
    end
    if isempty(idx2)
        error('Country "%s" not found in dataset.', country2);
    end

    % --- Extract feature vectors ---
    x1 = X(idx1, :);
    x2 = X(idx2, :);

end
