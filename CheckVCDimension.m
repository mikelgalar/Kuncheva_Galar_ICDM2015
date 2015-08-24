clear all
clc
close all

delta = [0.001,0.01,0.5];
N = 1000; % training set size
M = 1:N; % size of the reference set
R1 = sqrt((M.*(log2(2*N./M)+1)-log2(delta(1)/4))/N); % risk bound assuming
% consistent reference set
R2 = sqrt((M.*(log2(2*N./M)+1)-log2(delta(2)/4))/N); 
R3 = sqrt((M.*(log2(2*N./M)+1)-log2(delta(3)/4))/N); 

plot(M,R1,'k-')
hold on
set(gca,'FontName','Candara','FontSize',12)
grid on
plot(M,R2,'r--')
plot(M,R3,'b:')
legend('\delta = 0.001','\delta = 0.01','\delta = 0.05');

figure('color','w')
plot(M,R1,'k-','linewidth',2)
hold on
set(gca,'FontName','Candara','FontSize',16)
grid on
plot([1,1000],[1,1],'r--')
xlabel('Size of the reference set')
ylabel('VC confidence')
set(gca,'Box','off')


