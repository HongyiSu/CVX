% simple_portfolio_data
n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;

% A3Q8
ss = x_unif'*S*x_unif %risk x'*Var*x

stedv = sqrt(ss); % q1

cvx_begin
    variables x(n,1)
    minimize  (x'*S*x)
    subject to
        x'*pbar >= x_unif'*pbar
       % x>=0;
        ones(20,1)'*x==1;
        ones(20,1)'*max(-x,0)<=0.5;
cvx_end
 sqrt(cvx_optval)

        