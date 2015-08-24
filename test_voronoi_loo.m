function [e,AssignedLabels] = test_voronoi_loo(Data,Labels,IndexRef)

%========================================================================
% (c) Fox's Classification Toolbox                                  ^--^
% 28/05/2015 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

N = size(Data,1);
A = 1:N;
[E,AssignedLabels] = deal(zeros(N,1));
for i = 1:size(Data,1)
    index_loo = setxor(i,A);
    Dloo = Data(index_loo,:);
    DLloo = Labels(index_loo);
    if ismember(i,IndexRef)        
        Z = setxor(i,IndexRef); % exclude from refrence set
    else
        Z = IndexRef;
    end
    RefSet = Data(Z,:);
    CV = train_vr_refset(Dloo,DLloo,RefSet);
    [E(i),AssignedLabels(i)] = test_1nn(CV,Data(i,:),Labels(i)); 
end
e = mean(E);
