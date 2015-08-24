function C = train_1nn(TrainingData,TrainingLabels,~)
%
% Trains a nearest neighbour classifier
%
% PARAM is not used; included here for uniformity
%
% Constructs a structure C with the following fields
% C.name = classifier name
% C.valid labels = the labels of the classes which have at least
%    one element, arranged in ascending order (all numerical)
% C.ReferenceSet
% C.ReferenceLabels
%
% ---- example ----
%
%     C = train_linear(TrainingData,TrainingLabels,PARAM)
%
%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% v.1.0 2010 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

C.name = '1nn';
C.valid_labels = unique(TrainingLabels);
C.ReferenceSet = TrainingData;
C.ReferenceLabels = TrainingLabels;


