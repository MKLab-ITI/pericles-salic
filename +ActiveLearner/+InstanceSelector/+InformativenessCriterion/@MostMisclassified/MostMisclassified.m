classdef MostMisclassified < ActiveLearner.InstanceSelector.InformativenessCriterion.BaseCriterion
    %ACTIVELEARNING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Classifier;
    end
    
    methods
        function obj = MostMisclassified(Classifier) % constructor
            obj.Classifier = Classifier; % link to the classifier. 
            % Note that the model must have been already trained
        end
        function obj = GetInformativeness(obj,feats)
            [~,V] = obj.Classifier.predict(feats); % Get distances from the hyperplane
            obj.confidence_values = -V; % Compute informativess based on [1]
        end
    end
    
end

