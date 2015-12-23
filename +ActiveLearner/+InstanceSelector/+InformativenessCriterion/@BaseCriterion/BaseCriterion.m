classdef (Abstract) BaseCriterion < handle
    %BASECRITERION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Informativeness_values;
    end
    
    methods(Abstract = true)
        obj = GetInformativeness(obj,feats);
    end
    
end

