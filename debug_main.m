%% debug_main.m  -- run this to check types, sizes, and a forward pass
clear; clc; close all;

fprintf('Running debug_main...\n');

% 1) Make sure MATLAB sees the right files
fprintf('Which country_data: %s\n', which('country_data'));
fprintf('Which simple_nn:    %s\n', which('simple_nn'));
fprintf('Which init_params:  %s\n', which('init_params'));
fprintf('Which training_data_generator (may be missing): %s\n', which('training_data_generator'));

% 2) Load two countries
us = country_data("United States");
china = country_data("China");

% Print basic diagnostics
fprintf('class(us) = %s, size(us) = [%s]\n', class(us), num2str(size(us)));
fprintf('class(china) = %s, size(china) = [%s]\n', class(china), num2str(size(china)));

% Show first 6 elements
fprintf('us (first 6 features): %s\n', mat2str(us(1:min(6,end))));
fprintf('china (first 6 features): %s\n', mat2str(china(1:min(6,end))));

% 3) Initialize params and report shapes
numFeatures = 12;
params = init_params(2*numFeatures, 16, 1);

fprintf('size(W1) = [%s], size(b1) = [%s]\n', num2str(size(params.W1)), num2str(size(params.b1)));
fprintf('size(W2) = [%s], size(b2) = [%s]\n', num2str(size(params.W2)), num2str(size(params.b2)));

% 4) Forward pass
y_us_china = simple_nn(us, china, params);
fprintf('Forward pass result (US vs China): %.6f\n', double(y_us_china));

% 5) If you want to inspect Wars matrix
[cnames, X, Wars] = country_data();
fprintf('Wars matrix size: %s\n', mat2str(size(Wars)));
fprintf('Wars(China,India) (2,7) = %d\n', Wars(2,7));
fprintf('Debug finished.\n');