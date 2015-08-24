
clear all
clc
close all

load FiguresData
%addpath('D:\RESEARCH\export_fig')

Cr(1) = Cr(2);
figure('color','w','Pos',[100 100 500 800])
fos = 12; % font size
mas = 12;  % markersize

%% 1-nn

[mi,indmin] = min(LooMin1nn);
q = 1:N;
delta = 0.1;
R1 = sqrt((q.*(log2(2*N./q)+1)-log2(delta/4))/N); % risk bound assuming
% 0 resub error
subplot(4,2,1),plot(TrainingError1nn,'b.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('Training Error')
axis tight
set(gca,'Box','off')

subplot(4,2,3)
%plot(TestingError1nn,'r.-','linewidth',1,'markers',15)
hold on
plot(TrueMin1nn,'r.-','linewidth',1,'markers',mas)

grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('Testing Error')
axis tight
set(gca,'Box','off')
plot(indmin,TrueMin1nn(indmin),'go','linewidth',3,'markers',mas)

subplot(4,2,5),plot(LooMin1nn,'k.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('LOO error 1-nn')
axis tight
set(gca,'Box','off')
plot(indmin,mi,'go','linewidth',3,'markers',mas)


subplot(4,2,7)
plot(R1+TrainingError1nn,'k.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos,'color',[0.7 0.7 0.7])
ylabel('VC bound')
axis tight
set(gca,'Box','off')
xlabel('Reference set size')
    
%% FB ---------------------------------------------------------------------
[mi,indmin] = min(LooMinV);

subplot(4,2,2),plot(TrainingErrorV,'b.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('Training Error')
axis tight
set(gca,'Box','off')

subplot(4,2,4)
%plot(TestingErrorV,'rx-','linew',1,'markers',10)
hold on
plot(TrueMinV,'r.-','linewidth',1,'markers',mas)
grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('Testing Error')
axis tight
set(gca,'Box','off')
plot(indmin,TrueMinV(indmin),'go','linewidth',3,'markers',mas)

subplot(4,2,6),plot(LooMinV,'k.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos)
ylabel('LOO error (Voronoi)')
axis tight
set(gca,'Box','off')
plot(indmin,mi,'go','linewidth',3,'markers',mas)

subplot(4,2,8),plot(Cr,'k.-','linewidth',1,'markers',mas)
hold on
grid on
set(gca,'FontName','Candara','FontSize',fos,'color',[0.7 0.7 0.7])
ylabel('Criterion C')
axis tight
set(gca,'Box','off')
xlabel('Reference set size')

