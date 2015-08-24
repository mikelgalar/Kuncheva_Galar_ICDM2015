function [e,AssignedLabels] = test_edited_1nn_loo(Data,Labels,IndexRef)

%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% 28/05/2015 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

[E,AssignedLabels] = deal(zeros(size(Data,1),1));
for i = 1:size(Data,1)
    if ismember(i,IndexRef)        
        Z = setxor(i,IndexRef); % exclude from refrence set
    else
        Z = IndexRef;
    end
    RefSet = Data(Z,:);
    RefLabels = Labels(Z);
    C = train_1nn(RefSet,RefLabels);
    [E(i),AssignedLabels(i)] = test_1nn(C,Data(i,:),Labels(i)); 
end
e = mean(E);
