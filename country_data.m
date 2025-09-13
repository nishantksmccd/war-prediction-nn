function varargout = country_data(countryName)
% COUNTRY_DATA  Return country features and optional Wars matrix.
%
% Usage:
%   x = country_data("United States");        % returns 1x12 double row vector
%   [countries, X, Wars] = country_data();    % returns full dataset
%
% The function is robust to string or char input and always returns numeric.

    % ---- list of countries ----
    countries = {
        'United States'
        'China'
        'Russia'
        'Germany'
        'United Kingdom'
        'Japan'
        'India'
        'France'
        'South Korea'
        'Saudi Arabia'
        'Canada'
        'Brazil'
        'Australia'
        'Italy'
        'Turkey'
        'Switzerland'
        'Indonesia'
        'Mexico'
        'Spain'
        'Israel'
        'Pakistan'
    };

    % ---- Feature matrix (N x 12), numeric doubles ----
    X = [
        1.00, 0.037, 0.95, 1, 1.0, 0.0, 0.2, 0.1, 0.6, 0.9, 0.9, 0.2; % USA
        0.95, 0.018, 1.00, 1, 0.1, 1.0, 0.5, 0.6, 0.8, 0.3, 0.8, 0.4; % China
        0.60, 0.040, 0.65, 1, 0.0, 1.0, 0.6, 0.7, 0.7, 0.2, 0.7, 0.5; % Russia
        0.70, 0.013, 0.60, 0, 0.9, 0.1, 0.2, 0.1, 0.5, 1.0, 0.6, 0.2; % Germany
        0.68, 0.020, 0.55, 1, 0.9, 0.1, 0.3, 0.1, 0.6, 1.0, 0.7, 0.2; % UK
        0.65, 0.009, 0.50, 0, 0.9, 0.1, 0.1, 0.0, 0.4, 1.0, 0.6, 0.3; % Japan
        0.55, 0.025, 0.90, 1, 0.4, 0.6, 0.5, 0.5, 0.8, 0.6, 0.7, 0.5; % India
        0.62, 0.020, 0.55, 1, 0.9, 0.1, 0.3, 0.1, 0.6, 0.9, 0.6, 0.2; % France
        0.55, 0.026, 0.45, 0, 0.8, 0.2, 0.3, 0.4, 0.7, 0.9, 0.7, 0.3; % S Korea
        0.50, 0.085, 0.40, 0, 0.5, 0.5, 0.6, 0.4, 0.7, 0.2, 0.8, 0.7; % Saudi
        0.52, 0.013, 0.35, 0, 0.9, 0.0, 0.1, 0.0, 0.4, 1.0, 0.5, 0.2; % Canada
        0.57, 0.020, 0.80, 0, 0.5, 0.3, 0.3, 0.3, 0.7, 0.7, 0.6, 0.5; % Brazil
        0.53, 0.020, 0.35, 0, 0.8, 0.1, 0.1, 0.0, 0.5, 1.0, 0.6, 0.2; % Australia
        0.58, 0.016, 0.40, 0, 0.8, 0.2, 0.3, 0.1, 0.5, 1.0, 0.6, 0.2; % Italy
        0.48, 0.021, 0.45, 0, 0.6, 0.4, 0.5, 0.5, 0.8, 0.5, 0.7, 0.4; % Turkey
        0.45, 0.010, 0.20, 0, 0.8, 0.0, 0.0, 0.0, 0.3, 1.0, 0.4, 0.1; % Switzerland
        0.42, 0.010, 0.70, 0, 0.5, 0.5, 0.4, 0.5, 0.7, 0.6, 0.6, 0.6; % Indonesia
        0.44, 0.008, 0.65, 0, 0.7, 0.3, 0.2, 0.2, 0.6, 0.7, 0.5, 0.5; % Mexico
        0.47, 0.013, 0.40, 0, 0.8, 0.2, 0.2, 0.1, 0.5, 1.0, 0.5, 0.3; % Spain
        0.40, 0.055, 0.25, 1, 0.7, 0.2, 0.7, 0.4, 0.8, 0.5, 0.8, 0.6; % Israel
        0.35, 0.040, 0.70, 1, 0.4, 0.6, 0.6, 0.6, 0.9, 0.3, 0.7, 0.7; % Pakistan
    ];

    % ---- Wars matrix (symmetric) ----
    N = size(X,1);
    Wars = zeros(N,N);

    % --- Example synthetic entries (set pairs you want to flag) ---
    % Use indices corresponding to 'countries' list above:
    % 1=US, 2=China, 3=Russia, 7=India, 20=Israel, 21=Pakistan, etc.
    Wars(1,3)  = 0;  % USA-Russia: set 0 or 1 depending on your judgement
    Wars(2,7)  = 1;  % China-India
    Wars(3,7)  = 1;  % Russia-India
    Wars(7,21) = 1;  % India-Pakistan
    Wars(21,2) = 1;  % Pakistan-China
    % (add/remove entries above as you wish)

    % Symmetrize to ensure Wars(i,j) == Wars(j,i) and logical type
    Wars = double((Wars + Wars') > 0);

    % ---- Return logic ----
    if nargin == 0
        varargout{1} = countries;
        varargout{2} = X;
        varargout{3} = Wars;
        return;
    end

    % Convert string to char safely
    if isstring(countryName)
        countryName = char(countryName);
    end

    % Find index
    idx = find(strcmpi(countries, countryName), 1);
    if isempty(idx)
        error('country_data:NotFound', 'Country "%s" not found in dataset.', countryName);
    end

    % Return 1x12 numeric row vector
    varargout{1} = double(X(idx, :));
end
