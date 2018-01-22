% SUMMARY:  Clustering on IRIS dataset. 
% AUTHOR:   
% Created:  
% Modified: - 
% -----------------------------------------------------------
function main()
close all
clear all
clc

% Load data. 
load fisheriris
x = meas;
[n_samples, n_dim] = size(x);   % (150, 4)
n_classes = 3;  % Number of species. 
y = species; 

% Plot data. 
figure;
gscatter(x(:,1), x(:,2), species, 'rgb', 'osd');
xlabel('Sepal length');
ylabel('Sepal width');
title('Iris Data')

% ------ Your code here ------
n_clusters = 4;  % Number of clusters. 
pred = your_func(x, n_clusters);


% ------ Plot result ------
figure;
gscatter(x(:,1), x(:,2), pred, 'rgby');
xlabel('Sepal length');
ylabel('Sepal width');
title('Clustered result')


% ------ Evaluation ------
n_match = evaluate(pred, y, n_classes, n_clusters);
fprintf('Result: %d out of %d are matched!', n_match, n_samples);

end


% Clustering function. 
function [pred] = your_func(x, n_clusters)
    pred = kmeans(x, n_clusters);
end


% Evaluation. 
function [n_match] = evaluate(pred, y, n_classes, n_clusters)
    n_samples = length(pred);

    % Ground truth matrix. 
    y_mat = zeros(n_samples, n_classes);
    for n = 1 : n_samples
        if strcmp(y{n}, 'setosa')
            y_mat(n, 1) = 1;
        elseif strcmp(y{n}, 'versicolor')
            y_mat(n, 2) = 1;
        elseif strcmp(y{n}, 'virginica')
            y_mat(n, 3) = 1;
        end
    end

    % Prediction matrix. 
    pred_mat = zeros(n_samples, n_clusters);
    for n = 1 : n_samples
        pred_mat(n, pred(n)) = 1;
    end

    % Compute evaluation stat. 
    n_match = 0;
    for i1 = 1 : n_clusters
        n_intersects = [];
        for i2 = 1 : n_classes
            n_intersect = sum(pred_mat(:, i1) & y_mat(:, i2));
            n_intersects(i2) = n_intersect;
        end
        n_match = n_match + max(n_intersects);
    end
end