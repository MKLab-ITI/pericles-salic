classdef (Abstract) BaseFusion < handle
    %BASEFUSION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Oracle;
        InfCriterion;
        probs;
    end
    
    methods (Abstract = true)
        probs = Fuse(obj);
    end
    
end

