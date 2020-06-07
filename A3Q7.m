
%generate problem
rng(0,'v5uniform');
n=100;
m=300;
A = rand(m,n);
b = A*ones(n,1)/2;
c = -rand(n,1) % -c[i] is the revenue


cvx_begin
    variables x(n,1) 
        minimize(c'*x)
    subject to
        x <= 1; 
        x >= 0;
        A*x <= b
        
cvx_end

xrlx = x;
L = cvx_optval;

% sweep over threshold & round
thres = 0:0.01:1;
maxviol = zeros(length(thres),1);
obj = zeros(length(thres),1);
for i=1:length(thres)
    xhat = (xrlx>=thres(i));
   maxviol(i) = max(A*xhat - b);
   obj(i) = c'*xhat;
end
% find least upper bound and associated threshold
i_feas=find(maxviol<=0);
U=min(obj(i_feas))
t=min(i_feas);
min_thresh=thres(t)

% plot objective and max violation versus threshold
subplot(2,1,1)
plot(thres(1:t-1),maxviol(1:t-1),'r',thres(t:end),maxviol(t:end),'b','linewidth',2)
xlabel('threshold');
ylabel('max violation');
subplot(2,1,2)
hold on; plot(thres,L*ones(size(thres)),'k','linewidth',2);
plot(thres(1:t-1),obj(1:t-1),'r',thres(t:end),obj(t:end),'b','linewidth',2);
xlabel('threshold');
ylabel('objective');

abs(cvx_optval-U)
