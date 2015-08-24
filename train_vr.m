function C = train_vr(TrainingData,TrainingLabels,PARAM)
%
% Trains a Voronoi Region base-classifier
%
% Input: ---------------------------------------------------------------
%
% PARAM = array with parameters
%     seed_tag = PARAM(1) = 1 = constant percentage, PARAM(2), of seeds
%                           2 = binornd of seeds with mean PARAM(2)
%                           3 = random no of seeds; PARAM(2) not used 
%        value = PARAM(2) = 0.10 or 0.20 or 0.60 etc. 
%
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
[N,n] = size(TrainingData); % #objects, #features

rp = randperm(n);
nf = n;%randi(n); % features
mask = false(1,n); mask(rp(1:nf)) = true;

C.Features = mask;

rp = randperm(N); 
% percentage
if PARAM(1) == 1, nc = ceil(PARAM(2)*N); end;
% binornd
if PARAM(1) == 2, nc = binornd(N,PARAM(2)); end;
% random
if PARAM(1) == 3, nc = randi(N-1) + 1; end;

C.Centres = TrainingData(rp(1:nc),mask);
[~,La] = cellfun(@(x) min(sum(bsxfun(@minus, x,...
    C.Centres).^2, 2)), num2cell(TrainingData(:,mask),2));
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