classdef RandomCriterion < ActiveLearner.InstanceSelector.InformativenessCriterion.BaseCriterion
    %RANDOMSELECTOR Summary of this class goes here
    % Return 0.5 as a probability of selecting an image regardless of
    % feature values to accomodate random selection based on fusion tactics
    
    properties
    end
    
    methods
        function obj = RandomCriterion() % constructor
        end
        function obj = GetInformativeness(obj,feats)
            obj.confidence_values = 0.5*ones(size(feats,1),1); 
        end
        
    end
    
end


