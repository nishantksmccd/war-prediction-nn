%% main.m
% Driver script for the simple neural network demo

clear; clc; close all;

%% Step 1. Define network dimensions
numFeatures = 12;                 % features per country
inputSize   = 2 * numFeatures;    % two countries
hiddenSize  = 16;                 % hidden layer width
outputSize  = 1;                  % scalar prediction (probability)

%% Step 2. Initialize parameters
params = init_params(inputSize, hiddenSize, outputSize);

%% Step 3. Load sample country data
us    = country_data("United States");  % 1x12 row vector
china = country_data("China");          % 1x12 row vector
russia= country_data("Russia");         % 1x12 row vector

%% Step 4. Forward pass predictions
y_us_china  = simple_nn(us, china, params);
y_us_russia = simple_nn(us, russia, params);

%% Step 5. Display results
fprintf("Predicted war likelihood (US vs China):  %.4f\n", y_us_china);
fprintf("Predicted war likelihood (US vs Russia): %.4f\n", y_us_russia);

%% (Optional) Try all pairs of countries
% countries = ["United States","China","Russia","India","France"];
% for i = 1:numel(countries)
%     for j = i+1:numel(countries)
%         y = simple_nn(country_data(countries(i)), ...
%                       country_data(countries(j)), params);
%         fprintf("%s vs %s -> %.4f\n", countries(i), countries(j), y);
%     end
% end
