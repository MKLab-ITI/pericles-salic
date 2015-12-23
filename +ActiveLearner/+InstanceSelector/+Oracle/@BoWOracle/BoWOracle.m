classdef BoWOracle < ActiveLearner.InstanceSelector.Oracle.BaseOracle
    %BOWORACLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Classifier; % type = ClassifierBase
    end
    
    methods
        function obj = BoWOracle(Classifier) % constructor
            obj.Classifier = Classifier; % link to the classifier. 
            % Note that the model must have been already trained
        end
        function obj = GetOracleConfidence(obj,feats)
            [~,obj.confidence_values] = obj.Classifier.predict(feats);
        end
    end
    
end

