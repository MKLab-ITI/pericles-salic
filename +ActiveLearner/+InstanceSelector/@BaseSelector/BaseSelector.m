classdef (Abstract) BaseSelector < handle
    %BASESELECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Dataset;
        selected_ids; % bx1 matrix. The ids of the b selected samples; 
        % they refer to the Dataset feats
        labels; % bx1 the labels of the selected samples, i.e. a column 
        % vector of {+1,-1}'s, one for each selected sample
    end
    
    methods (Abstract = true)
        obj = SelectSamples(obj); % The fucntion that selects new samples
    end
    
end

