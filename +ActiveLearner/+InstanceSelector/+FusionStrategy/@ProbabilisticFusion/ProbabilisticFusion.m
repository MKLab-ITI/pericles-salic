classdef ProbabilisticFusion < ActiveLearner.InstanceSelector.FusionStrategy.BaseFusion
    %PROBABILISTICFUSION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = ProbabilisticFusion(Oracle,InfCriterion) %constructor
            obj.Oracle=Oracle;
            obj.InfCriterion = InfCriterion;
        end
        function probs = Fuse(obj)
            obj.Oracle.GetOracleConfidence();
            obj.InfCriterion.GetInformativeness();
            pt = obj.Oracle.confidence_values;
            pv = obj.InfCriterion.Informativeness_values;
            pv(pv>=0.99) = 0.99;
            pt(pt>=1) = 0.99999999999999;
            probs = 0.5*pv.*pt./(pv.*pt-0.5*pv-0.5*pt+0.5);
            obj.probs = probs;
        end
    end
    
end

