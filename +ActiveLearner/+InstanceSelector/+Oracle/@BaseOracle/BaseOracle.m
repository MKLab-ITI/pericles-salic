classdef (Abstract) BaseOracle < handle
    %BASEORACLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        confidence_values;
    end
    
    methods (Abstract = true)
        obj = GetOracleConfidence(obj,feats);
    end
    
end

