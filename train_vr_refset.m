function C = train_vr_refset(TrainingData,TrainingLabels,RefSet)
%
% Trains a Voronoi Region base-classifier
%
% Input: ---------------------------------------------------------------

% Output: --------------------------------------------------------------
% C is a structure
% C.name = 'voronoi region'
% C.features = the random feature subsets
% C.Classifiers = the trained classifiers
%
%
%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% v.1.0 2013 -----------------------------------------------------  \oo/%
% -------------------------------------------------------------------\/-%

zz = tabulate(TrainingLabels);
[~,largest_class] = max(zz(:,2));
C.name = 'voronoi region classifier';
C.valid_labels = 1:max(TrainingLabels);
[~,n] = size(TrainingData); % #objects, #features

rp = randperm(n);
nf = n;%randi(n); % features
mask = false(1,n); mask(rp(1:nf)) = true;

C.Features = mask;

C.Centres = RefSet(:,mask);
nc = size(RefSet,1);

AuxC = train_1nn(C.Centres,(1:nc)');

[~,La] = test_1nn(AuxC,TrainingData(:,mask));

for j = 1:nc
    C.Labels(j) = mode(TrainingLabels(La==j));
    C.Count(j) = sum(La==j);
    ar = zeros(1,numel(C.valid_labels));
    ta = tabulate(TrainingLabels(La==j));
    if ~isempty(ta)
        ar(ta(:,1)) = ta(:,2);
    else
        ar(largest_class) = 1;
    end
    C.Posteriors(j,:) = ar;
end

C.ReferenceSet = C.Centres;
C.ReferenceLabels = C.Labels;