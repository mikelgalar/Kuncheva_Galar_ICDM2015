clear all
clc
close all

T = 2000;
N = 18;

rng(1959)
[d,LabelsTr] = gendatcb(T,0.25,0);
[DS,DSL] = gendatcb(N,0.25,0);

p = @(d,LabelsTr,a,b,c,colo) ...
    plot(d(LabelsTr==a,1),d(LabelsTr==a,2),b,'markers',c,...
    'linew',3,'color',colo);
figure('color','w')
hold on
p(d,LabelsTr,1,'g.',15,[0.8 1 0.8])
p(d,LabelsTr,2,'k.',15,[0.8 0.8 0.8])

% Data Set

p(DS,DSL,1,'gx',15,[0 0.7 0])
p(DS,DSL,2,'k.',25,'k')

axis([0 1 0 1])
axis square
set(gca,'FontName','Candara','FontSize',14,'layer','top',...
    'XTick',0:0.25:1,'YTick',0:0.25:1)
grid on

% All reference subsets
z = 1;
for M = 1:N
    alls = nchoosek(1:N,M);
    for i = 1:size(alls,1)
        RS = DS(alls(i,:),:);
        RSL = DSL(alls(i,:));
        CV = train_vr_refset(DS,DSL,RS);
        EtrV(z) = test_1nn(CV,DS,DSL);
        EtsV(z) = test_1nn(CV,d,LabelsTr);
        C = train_1nn(RS,RSL);
        Etr1nn(z) = test_1nn(C,DS,DSL);
        Ets1nn(z) = test_1nn(C,d,LabelsTr);
        ClassifierV{z} = CV;
        Prototypes{z} = alls(i,:);
        Size(z) = M;
        z = z + 1;
    end
    fprintf('Cardinality %i done.\n',M)
end
