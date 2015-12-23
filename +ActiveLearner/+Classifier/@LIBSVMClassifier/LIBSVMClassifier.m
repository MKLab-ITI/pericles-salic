classdef LIBSVMClassifier < ActiveLearner.Classifier.ClassifierBase
    %LIBSVMCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        kernel; % The svm kernel
        cost; % The cost parameter
        gamma; % The gamma parameter (not required for linear kernel)
        models; % The trained models
    end
    
    methods
        function obj = LIBSVMClassifier(kernel,cost,gamma)
            % Default prms
            obj.kernel = 'linear';
            obj.cost = 1.0;
            obj.gamma = 0.01;
            if nargin > 0
                obj.kernel = kernel;
            end
            if nargin > 1
                obj.cost = cost;
            end
            if nargin > 2
                obj.gamma = gamma;
            end
        end
        
        function obj = train(obj, instances, labels)
            % Builds the classification model
            switch obj.kernel
                case 'linear'
                    obj.models = svmtrain(labels, instances, sprintf('-t %d -c %f -q', obj.kernel, obj.cost));
                case 'rbf'
                    obj.models = svmtrain(labels, instances, sprintf('-t %d -c %f -g %f -q', obj.kernel, obj.cost, obj.gamma));
                otherwise
                    error('invalid kernel parameter');
            end
        end
        
        function [labels, scores] = predict(obj,instances)
            %input = instance matrix rows = instances, cols = attributes
            %output = predicted class
            %probabilities = probability for predicted class
            %ranking = propabilities for all classes (e.g. to use with mAP)
            
            %TODO:should print an error if 'build' has not been called
            [numinstance, ~] = size(instances);
            %predict using the stored models
            [labels, ~, scores] = svmpredict(eye(numinstance,1),instances, obj.models,'-q');
        end
        
    end
    
end