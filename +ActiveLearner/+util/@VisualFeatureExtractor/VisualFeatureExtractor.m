classdef VisualFeatureExtractor
    %VISUALFEATUREEXTRACTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        img_files;
        
        outfolder; % folder where the visual features will be saved
        param_file; % file with the word vocabulary
        model_file; % file with the PCA coefficients
        model_dir; % directory where the CNN models are
        average_image % file with mean image
        Dataset; % Name of the Dataset
    end
    
    methods
        function obj = VisualFeatureExtractor(Dataset_name,img_files)
            if nargin == 0
                error('VisualFeatureExtractor cannot be initialized without a Dataset name')
            end
            obj.Dataset = Dataset_name;
            
            % Set default prms
            obj.outfolder= fullfile('./data/',obj.Dataset);
            obj.model_dir = './models/CNN_M_128';
            obj.param_file = sprintf('%s/param.prototxt', obj.model_dir);
            obj.model_file = sprintf('%s/model', obj.model_dir);
            obj.average_image = './models/mean.mat';
            if nargin > 1
                obj.img_files = img_files;
            end
        end
        
        function [feats errImages] = ExtractCNNfeats(obj)
            featFile = fullfile(obj.outfolder,'Vis_feats.mat');
            if exist(obj.featFile,'file')
                disp([obj.featFile 'already exists... Loading features...']);
                load(obj.featFile);
            else
                % initialize an instance of the ConvNet feature encoder class;
                encoder = featpipem.directencode.ConvNetEncoder(obj.param_file, obj.model_file, ...
                    obj.average_image, 'output_blob_name', 'fc7');
                for i=1:numel(obj.img_files)
                    imgName = obj.img_files{i};
                    disp(['Extracting features for image ' imgName]);
                    try
                        im = imread(imgName);
                        im = featpipem.utility.standardizeImage(im);
                        code = encoder.encode(im);
                        feats(:,i) = code;
                    catch err
                        errImages = [errImages;i];
                    end
                end
                save(featFile,'feats','errImages');
            end
        end
    end
    
end

