function [e,AssignedLabels] = test_1nn(C,Data,Labels)
%
% Tests a nearest neighbour classifier trained through train_1nn
%
% Input:
%     C = the classifier structure returned by the training routine
%     Data = the data to be classified
%     Labels = class labels (optional)
%
% Output
%     e = the classification error of C on the submitted Data/Labels
%         (if labels are not submitted, e is infinity)
%     AssignedLabels = a column vector with the assigned labels
%
% ---- example ----
%
%     [e,AssignedLabels] = test_1nn(C,Data,Labels)
%
%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% v.1.0 2013 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

ref_set = C.ReferenceSet;
ref_lab = C.ReferenceLabels;

% This seems to be far too slow... :(
% [~,label_index] =  cellfun(@(x) min(sum(bsxfun(@minus, x,...
%     ref_set).^2, 2)), num2cell(Data,2));

di = pdist2(Data,ref_set);
if size(di,2) == 1; 
    label_index = 1;
else
    [~,label_index] = min(di');
end

AssignedLabels = ref_lab(label_index(:));

if nargin == 2 % labels not specified
    e = inf; % error
else
    e = mean(AssignedLabels(:)~=Labels(:));
end
