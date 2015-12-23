function AP = Wrapper( prms )
%WRAPPER Calls all the necessary functions to perform Active Learning (AL)
%   Gets as input all the parameters (see demo.m) and calls all the
%   functions for AL (i.e. trains a baseline classifier, and for N
%   iterations calls the active selector, selects a sets of samples from
%   the pool, retrains the classifier and evaluates all the classifiers).
%   In the end, returns the evaluator

%% Init parameters
prms.TrainSet = 'ImageClef_train';
prms.Pool = 'MIRFlickr';
prms.TestSet = 'ImageClef_test';
prms.N = 50; % #iterations
prms.pos = 50; % #positive instances selected in each iteration
prms.neg = 50; % #negative instances selected in each iteration

%% Load Datasets & Extract Features
VFE = ActiveLearner.util.VisualFeatureExtractor(); % initialize VFE
TFE = ActiveLearner.util.TextualFeatureExtractor(); % initialize TFE

trainDataset = ActiveLearner.util.Dataset(prms.TrainSet); % training set
trainDataset.txt_feats = TFE.ExtractTextFeatures(prms.TrainSet);
trainDataset.vis_feats = VFE.ExtractCNNfeats(prms.TrainSet);
trainDataset.labels = []; % labels of training set

poolDataset = ActiveLearner.util.Dataset(prms.Pool); % pool of candidates
poolDataset.txt_feats = TFE.ExtractTextFeatures(prms.Pool);
poolDataset.vis_feats = VFE.ExtractCNNfeats(prms.Pool);

testDataset = ActiveLearner.util.Dataset(prms.TestSet); % test set
testDataset.vis_feats = VFE.ExtractCNNfeats(prms.TestSet); 
testDataset.labels = []; % labels of testset

%% Train Baseline Classifier
LSVM{1} = ActiveLearner.Classifier.LIBSVMClassifier(trainDataset);
LSVM{1} = LSVM{1}.train(trainDataset.vis_feats,trainDataset.labels); % train
[~,scores] = LSVM{1}.predict(testDataset.vis_feats); % test


%% Actively select new samples and retrain

% Set the selector
IS = ActiveLearner.InstanceSelector.BaseSelector();
% Loop over iterations
for i=1:prms.N
    [feats labs] = IS.getInstances(poolDataset);
    trainDataset = trainDataset.addInstances(feats,labs);
    LSVM = LSVM.train(trainDataset.vis_feats,trainDataset.labels); % train
    [~,scores] = LSVM.predict(testDataset.vis_feats); % test
end

%% Show results


end

