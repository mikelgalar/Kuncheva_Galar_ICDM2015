clear all
clc
close all


r = @(N,n,M,e) (n+1)*M*(M-1)*(log(N)+1-log(n+1))+log(8)-N*e^2/32;

% DW1 --------------------------------------------------------------------
T = 10:200000;

figure('color','w')
hold on
set(gca,'FontName','Candara','FontSize',14)
e1 = r(T,1,2,0.2);
e2 = r(T,1,2,0.15);
e3 = r(T,1,2,0.1);
plot(T,e1,'k-','linewidth',1.5)
plot(T,e2,'k-','linewidth',1.5)
plot(T,e3,'k-','linewidth',1.5)
plot([0 max(T)],[0 0],'r--','linewidth',1.5)

i1 = find(e1<0);
plot(i1(1),0,'ro','linewidth',1.5,'markers',10)
plot(i1(1),0,'k.','markers',16)
t(1) = text(i1(1)-15000,-15,num2str(i1(1)));
i2 = find(e2<0);
plot(i2(1),0,'ro','linewidth',1.5,'markers',10)
plot(i2(1),0,'k.','markers',16)
t(2) = text(i2(1),13,num2str(i2(1)));
i3 = find(e3<0);
plot(i3(1),0,'ro','linewidth',1.5,'markers',10)
plot(i3(1),0,'k.','markers',16)
t(3) = text(i3(1),13,num2str(i3(1)));
xlabel('Sample size N')
set(gca,'XTickLabel',0:50000:200000)
ylabel('log(\beta)')
grid on

t(4) = text(112000,-100,'\epsilon = 0.20','BackgroundColor','w');
t(5) = text(142000,-55,'\epsilon = 0.15','BackgroundColor','w');
t(6) = text(192000,-20,'\epsilon = 0.10','BackgroundColor','w');

set(t,'FontName','Candara','FontSize',14)

% DW2 --------------------------------------------------------------------
T = 10:300000;

figure('color','w')
hold on
set(gca,'FontName','Candara','FontSize',14)
e1 = r(T,1,3,0.15);
e2 = r(T,1,2,0.15);
e3 = r(T,2,2,0.15);

plot(T,e1,'b-','linewidth',1.5)
plot(T,e2,'k-','linewidth',1.5)
plot(T,e3,'g-','linewidth',1.5)
plot([0 max(T)],[0 0],'r--','linewidth',1.5)

i1 = find(e1<0);
plot(i1(1),0,'ro','linewidth',1.5,'markers',10)
plot(i1(1),0,'k.','markers',16)
t(1) = text(i1(1)-15000,-15,num2str(i1(1)));
i2 = find(e2<0);
plot(i2(1),0,'ro','linewidth',1.5,'markers',10)
plot(i2(1),0,'k.','markers',16)
t(2) = text(i2(1)-20000,-13,num2str(i2(1)));
i3 = find(e3<0);
plot(i3(1),0,'ro','linewidth',1.5,'markers',10)
plot(i3(1),0,'k.','markers',16)
t(3) = text(i3(1),13,num2str(i3(1)));
xlabel('Sample size N')
set(gca,'XTickLabel',0:50000:300000)
ylabel('log(\beta)')
grid on


t(4) = text(170000,-115,'{\it M} = 2,  {\it n} = 1','BackgroundColor','w');
t(5) = text(60000,95,'{\it M} = 3,  {\it n} = 1','BackgroundColor','w');
t(6) = text(200000,-60,'{\it M} = 2,  {\it n} = 2','BackgroundColor','w');

set(t,'FontName','Candara','FontSize',14)

return
