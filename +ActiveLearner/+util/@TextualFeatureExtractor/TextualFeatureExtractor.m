classdef TextualFeatureExtractor
    %TEXTUALFEATUREEXTRACTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tag_files;
        Vocabulary;
        COEFF;
        NofDims;
        method;
        outfolder; % folder where the textual features will be saved
        VocabFileName; % file with the word vocabulary
        PCAFileName; % file with the PCA coefficients
        Dataset_name; % Name of the Dataset
    end
    
    methods
        function obj = TextualFeatureExtractor(Dataset_name, tag_files)
            if nargin == 0
                error('TextualFeatureExtractor cannot be initialized without a Dataset name')
            end
            obj.Dataset_name = Dataset_name;
            
            % Set default prms
            obj.outfolder= fullfile('./data/',obj.Dataset_name);
            obj.VocabFileName = fullfile('./data/Vocabulary.mat');
            obj.PCAFileName = fullfile('./data/PCA_coeffs.mat');
            obj.NofDims = 7000;
            if nargin > 1
                obj.tag_files = tag_files;
            end
        end
        function feats = ExtractTextFeatures(obj)
            if ~exist(obj.outfolder,'dir')
                mkdir(obj.outfolder);
            end
            featFile = fullfile(obj.outfolder,'Text_feats.mat');
            if ~exist(featFile,'file') % if feats have not been calculated
                obj = load(obj.VocabFileName); % load the Vocabulary
                obj = load(obj.PCAFileName); % load the PCA coefficients
                feats = zeros(numel(obj.tag_files),obj.NofDims);
                for i=1:numel(obj.tag_files)
                    [~, ~, ext] = fileparts(obj.tag_files{i});
                    switch ext
                        case 'mat'
                            load(obj.tag_files{i}); % load the tags from mat file
                        case 'txt'
                            Tags = importdata(obj.tag_files{i}); % load the tags from txt file
                        otherwise
                            load(obj.tag_files{i}); % if no extension, assume it is mat file
                    end
                    ids = ismember(obj.Vocabulary,Tags);
                    feats(i,:) = single(ids*obj.COEFF);
                    x = norm(feats(i,:)) ;
                    if x~=0
                        feats(i,:)=feats(i,:)/x;
                    end
                end
                feats = sparse(feats)';
                save(featFile,'feats','-v7.3');
            else
                load(featFile);
            end
        end
        
    end
end
