
%%%%%%%%%%%%%%%%%% --- This takes about 5 hours to run %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% --- so don't delete file Toy18a :)  %%%%%%%%%%%%%%%%%%%
% T = 2000;
% N = 18;
% rng(1959)
% [d,LabelsTr] = gendatcb(T,0.25,0);
% [DS,DSL] = gendatcb(N,0.25,0);
% 
% % All reference subsets
% A = 1:N;
% z = 1;
% for M = 1:N
%     alls = nchoosek(1:N,M);
%     for i = 1:size(alls,1)
%         RS = DS(alls(i,:),:);
%         RSL = DSL(alls(i,:));
%         CV = train_vr_refset(DS,DSL,RS);
%         EtrV(z) = test_1nn(CV,DS,DSL);
%         EtsV(z) = test_1nn(CV,d,LabelsTr);
%         C = train_1nn(RS,RSL);
%         Etr1nn(z) = test_1nn(C,DS,DSL);
%         Ets1nn(z) = test_1nn(C,d,LabelsTr);
%         ClassifierV{z} = CV;
%         Prototypes{z} = alls(i,:);
%         
%         [AuV,Au1nn] = deal(zeros(1,N));
%         for j = 1:N
%             loo_index = setxor(A,j);
%             DSloo = DS(loo_index,:);
%             DSLloo = DSL(loo_index);
%             if ismember(j,alls(i,:))
%                 Z = setxor(alls(i,:),j);
%             else
%                 Z = alls(i,:);
%             end
%             if isempty(Z)
%                 AuV(j) = 0.5;
%                 Au1nn(j) = 0.5;
%             else
%                 CV = train_vr_refset(DSloo,DSLloo,DS(Z,:));
%                 AuV(j) = test_1nn(CV,DS(j,:),DSL(j));
%                 C = train_1nn(DS(Z,:),DSL(Z));
%                 Au1nn(j) = test_1nn(C,DS(j,:),DSL(j));
%             end
%         end
%         ErrorLOOV(z) = mean(AuV);
%         ErrorLOO1nn(z) = mean(Au1nn);
%         Size(z) = M;
%         z = z + 1;
%     end
%     fprintf('Cardinality %i done.\n',M)
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
close all

load Toy18a

fos = 12; % font size
%%
for i = 1:N
    index = find(Size == i);    
    [TrainingError1nn(i),mi1nn] = min(Etr1nn(index));
    TestingError1nn(i) = Ets1nn(index(mi1nn));
    [TrueMin1nn(i),itm1nn] = min(Ets1nn(index));
    LooMin1nn(i) = min(ErrorLOO1nn(index));
    Pro1nn{i} = Prototypes {index(itm1nn)};

    [TrainingErrorV(i),miV] = min(EtrV(index));
    TestingErrorV(i) = EtsV(index(miV));
    [TrueMinV(i),itmV] = min(EtsV(index));
    LooMinV(i) = min(ErrorLOOV(index));
    ProV{i} = Prototypes {index(itmV)};
end

[mi,indmin] = min(LooMin1nn);

fprintf('1-nn M = %i, e = %.4f, looe = %.4f\n\n',...
    indmin,mi,TrueMin1nn(indmin))

fprintf('Voronoi M = %i, e = %.4f, looe = %.4f\n\n',...
    indmin,mi,TrueMinV(indmin))
  
%%
% figure,hold on
A = (1:N)/N;

for a = [0.1 0.2 0.4 0.5 0.6 0.8 0.9]
    Cri = TrainingError1nn*(1-a) + a*A;
    [~,ind1nn] = min(Cri);
    Cri2 = LooMin1nn*(1-a) + a*A;
    [~,ind1nn2] = min(Cri2);
%     
%     plot(Cri,'k.-')
%     plot(Cri2,'r.-')
%     pause
    
    fprintf('%.1f & %i & %.2f & %i & %.2f &',a, ind1nn, ...
        TrueMin1nn(ind1nn)*100,ind1nn2, TrueMin1nn(ind1nn2)*100)
        
    Cri = TrainingErrorV*(1-a) + a*A;
    [~,indV] = min(Cri);
    Cri2 = LooMinV*(1-a) + a*A;
    [~,indV2] = min(Cri2);
% 
%     plot(Cri,'b-')
%     plot(Cri2,'g-')
%     pause

    
    fprintf(' %i & %.2f &  %i & %.2f\\\\\n', indV, TrueMinV(indV)*100,...
        indV2, TrueMinV(indV2)*100)
        
end


