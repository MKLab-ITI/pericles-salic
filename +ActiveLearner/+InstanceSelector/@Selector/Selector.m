classdef Selector < ActiveLearner.InstanceSelector.BaseSelector
    %SELECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Fuser;
        InfCriterion;
        Oracle;
        pos;
        neg;
        oldIDs;
        errIDs;
        zeroIDs;
    end
    
    methods
        % constructor
        function IS = Selector()
            IS.InfCriterion = ActiveLearner.InstanceSelector.InformativenessCriterion.ActiveLearning(IS.Dataset.feats);
            IS.Oracle = ActiveLearner.InstanceSelector.Oracle.BoWOracle(IS.Dataset.bow);
            IS.Fuser = ActiveLearner.InstanceSelector.FusionStrategy.ProbabilisticFusion(IS.InfCriterion ,IS.Oracle);
            IS.pos = 50;
            IS.neg = 50;
            IS.oldIDs = [];
            IS.errIDs = [];
            IS.zeroIDs = [];
        end
        function [selected_ids,labels] = GetConfidence(IS)
            % Get as input apart from the Dataset a Visual and textual
            % classifier
            probs = IS.Fuser.Fuse();
            [~,selected_ids] = sort(probs);
            IS.selected_ids = selected_ids;
            labels = Dataset.labels(selected_ids);
            IS.labels = labels;
        end
    end
    
end

