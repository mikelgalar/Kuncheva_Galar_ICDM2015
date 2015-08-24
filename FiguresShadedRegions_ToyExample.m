clear all
clc
close all

load Toy18a

%%

p = @(d,LabelsTr,a,b,c,colo) ...
    plot(d(LabelsTr==a,1),d(LabelsTr==a,2),b,'markers',c,...
    'linew',3,'color',colo);

%%
for i = 1:N
    index = find(Size == i);    
    [TrainingError1nn(i),mi1nn] = min(Etr1nn(index));
    TestingError1nn(i) = Ets1nn(index(mi1nn));
    [TrueMin1nn(i),itm1nn] = min(Ets1nn(index));
    Pro1nn{i} = Prototypes {index(itm1nn)};

    [TrainingErrorV(i),miV] = min(EtrV(index));
    TestingErrorV(i) = EtsV(index(miV));
    [TrueMinV(i),itmV] = min(EtsV(index));
    ProV{i} = Prototypes {index(itmV)};
    
    Co = log(nchoosek(N+i-1,i)); % the constant
    Rcl = ClassifierV{index(miV)};
    Rcl.Posteriors(Rcl.Posteriors==0) = 1;
    for k = 1:i
        Te1(k) = log(Rcl.Count(k)+1);
        Te2(k) = -Rcl.Posteriors(k,1)*log(Rcl.Posteriors(k,1))...
            -Rcl.Posteriors(k,2)*log(Rcl.Posteriors(k,2));
    end
    Cr(i) = Co + sum(Te1 + Rcl.Count(k)*Te2);
    fprintf('%i\n',i)
    
end

%% Boundaries

[xx,yy] = meshgrid(0:0.02:1,0:0.02:1);

% 1-nn
[~,BestRS1nn] = min(TrueMin1nn);
C1nnbest = train_1nn(DS(Pro1nn{BestRS1nn},:),DSL(Pro1nn{BestRS1nn}));
e = test_1nn(C1nnbest,d,LabelsTr)
[~,AssignedLabels] = test_1nn(C1nnbest,[xx(:),yy(:)]);

figure('color','w')
hold on
p(d,LabelsTr,1,'gx',15,[0.4 1 0.4])
p(d,LabelsTr,2,'k.',15,[0.8 0.8 0.8])

% Data Set

p(DS,DSL,1,'gx',15,[0 0.7 0])
p(DS,DSL,2,'k.',25,'k')
p(DS(Pro1nn{BestRS1nn},:),DSL(Pro1nn{BestRS1nn}),1,'go',15,[0 0.7 0])
p(DS(Pro1nn{BestRS1nn},:),DSL(Pro1nn{BestRS1nn}),2,'ko',15,'k')


axis([0 1 0 1])
axis square
set(gca,'FontName','Candara','FontSize',20,'layer','top',...
    'XTick',0:0.25:1,'YTick',0:0.25:1)
grid on
contour(xx,yy,reshape(AssignedLabels,size(xx)),...
    1.5,'k-','linewidth',2)

% Voronoi
[~,BestRSV] = min(TrueMinV);
CVbest = train_vr_refset(DS,DSL,DS(ProV{BestRSV},:));
[~,AssignedLabels] = test_1nn(CVbest,[xx(:),yy(:)]);
[~,AL] = test_1nn(CVbest,DS(ProV{BestRSV},:)); % labels assigned to the 
% CHOSEN prototypes

figure('color','w')
hold on
p(d,LabelsTr,1,'gx',15,[0.4 1 0.4])
p(d,LabelsTr,2,'k.',15,[0.8 0.8 0.8])

% Data Set
Se = DS(ProV{BestRSV},:); SeL = DSL(ProV{BestRSV});

p(DS,DSL,1,'gx',15,[0 0.7 0])
p(DS,DSL,2,'k.',25,'k')
p(Se,SeL,1,'go',15,[0 0.7 0])
p(Se,SeL,2,'ko',15,'k')

index_relabelled = SeL~=AL(:);
plot(Se(index_relabelled,1),Se(index_relabelled,2),...
    'rs','markers',26,'linewidth',3)

axis([0 1 0 1])
axis square
set(gca,'FontName','Candara','FontSize',20,'layer','top',...
    'XTick',0:0.25:1,'YTick',0:0.25:1)
grid on
contour(xx,yy,reshape(AssignedLabels,size(xx)),...
    1.5,'k-','linewidth',2)