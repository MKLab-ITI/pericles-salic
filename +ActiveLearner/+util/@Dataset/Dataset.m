classdef Dataset
    %DATASET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Dataset_name; % name of the Dataset
        feats; % DxM matrix, where D is the feature dimensionality
        % (M D-dimensional columns of features)
        labels; % a vector of Mx1 labels (+1 or -1)
        bow; % textual bow features, DxM matrix, where D is the feature 
        % dimensionality (M D-dimensional columns of features)
    end
    
    methods
        function obj = Dataset(Dataset_name,feats,labels)
            if nargin == 0
                error('Dataset cannot be initialized without a Dataset name')
            end
            obj.Dataset_name = Dataset_name;
            if nargin == 2
                obj.feats = feats;
            elseif nargin == 3
                obj.labels = labels;
            end
        end
        
        function instance = getInstancesWithIndices(obj, idx)
            % get instances of specific indices
            instance = obj.instances(idx,:);
        end
        function labels = getLabels(obj)
            % get the labels
            labels = obj.labels;
        end
        
        function [numLabels numInstances numFeatures] = getInfo(obj)
            % get the number of labels
            numLabels = numel(unique(obj.getLabels()));
            % get the number of instances and features
            [numFeatures numInstances] = size(obj.vis_feats);
            if numFeatures==0 || numInstances==0 % if the visual features have not been set yet
                [numFeatures numInstances] = size(obj.txt_feats);
            end
            if numFeatures==0 || numInstances==0 % if neither textual features have been set yet
                fprintf('Warning: Dataset %s does not have visual or textual features yet',obj.Dataset_name);
            end
        end
        
        function obj = removeInstancesWithIndices(obj, idx)
            % remove instances with specific indices. A new Dataset
            % object is returned by this functioned without the specified
            % instances
            obj.vis_feats(:,idx) = [];
            obj.txt_feats(:,idx) = [];
            obj.labels(idx,:) = [];
        end
        
        
    end
    
end

