clear all; close all
c = zeros(100,100);
Ex1 = 8;
Ex2 = 20;
std1 = 6;
std2 = 17.5;
corre = -0.25

r1=-30;
rn=70;
n=100;
r=linspace(r1,rn,n);

for i=1:100
    c(i,1) = r(i)
    c(1,i) = r(i)
end
new =zeros(100,100);
%P_loss = Prob(R1+R2<=0)
cvx_begin
    variables p(100,100)
    maximize sum(sum(p(1:30,1:30)))
    subject to
        p >= 0;
        sum(sum(p)) == 1;
        sum(p)*c(:,1) == Ex1;
        sum(p')*c(:,1) == Ex2; 
        sum(p)*c(:,1).^2-Ex1^2 == std1^2;
        sum(p')*c(:,1).^2-Ex2^2 == std2^2;
       
        c(1,:)*p*c(:,1)-Ex1*Ex2 == std1*std2*corre

%        =corre*std1*std2+Ex1*Ex2;

cvx_end