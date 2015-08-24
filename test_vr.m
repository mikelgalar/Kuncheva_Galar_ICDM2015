function [e,AssignedLabels] = test_vr(C,TestingData,TestingLabels)
%
% Tests an Voronoi Region enesmble trained through train_lp
%
% Input: ---------------------------------------------------------------
% C = classifier trained through train_lp
%
% Output: --------------------------------------------------------------
% e = error on the testing data
%
%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% v.1.0 2010 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

[~,Labs] = cellfun(@(x) min(sum(bsxfun(@minus, x,C.Centres).^2, 2)), ...
                        num2cell(TestingData(:,C.Features),2));

AssignedLabels = C.Labels(Labs)';

e = mean(AssignedLabels~=TestingLabels);
end
