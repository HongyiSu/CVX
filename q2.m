
% R1,R2 are gaussian
% R1 + R2 ~ N(mu1 + mu2, sigma1^2 + sigma2^2 + 2*sigma1*sigma2*p)
n = 100;
mu1 = 8;
mu2 = 20;
sigma1 = 6;
sigma2 = 17.5;
rho = -0.25;
r_i = linspace(-30,70,n)'; % These are the expectation values

% ploss = 0.05;
p_j1 = 0;
p_j2 = 0;
for j = 1:n
    p_j1 = p_j1 + (exp(-(r_i(j)-mu1)^2/(2*sigma1^2)));
    p_j2 = p_j2 + (exp(-(r_i(j)-mu2)^2/(2*sigma2^2)));
end

p_i1 = zeros(n,1);
p_i2 = zeros(n,1);
for i = 1:n
    p_i1(i) = (exp(-(r_i(i)-mu1)^2/(2*sigma1^2)))/p_j1;
    p_i2(i) = (exp(-(r_i(i)-mu2)^2/(2*sigma2^2)))/p_j2;
end


r1_mtx = r_i*ones(1,n);
r2_mtx = ones(n,1)*r_i';
loss_mtx = (r1_mtx+r2_mtx<=0);

cvx_begin
    
    variable ploss(n,n)
    maximize(sum(sum(ploss(loss_mtx))))
    subject to
        sum(p_i1) + sum(p_i2) == 1;
        ploss >= 0;
        ploss*ones(n,1) == p_i1;%rows sum to 1
        ploss'*ones(n,1) == p_i2;%columns sum to 1
        (r_i - mu1*ones(n,1))' * ploss * (r_i - mu2*ones(n,1)) == sigma1*sigma2*rho;
      %  r_i' * ploss * r_i == sigma1*sigma2*rho ;

        % We want the largest value in the matrix

cvx_end

plot(ploss*ones(n,1))