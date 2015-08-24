function [d,labd] = gendatcb(N,a,alpha)
% N data points, uniform distribution, 
% checkboard with side a, rotated at alpha
d = rand(N,2);
d_transformed = [d(:,1)*cos(alpha)-d(:,2)*sin(alpha), ...
               d(:,1)*sin(alpha)+d(:,2)*cos(alpha)];
s = ceil(d_transformed(:,1)/a)+floor(d_transformed(:,2)/a);
labd = 2-mod(s,2);
