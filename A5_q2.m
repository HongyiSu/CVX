
Ex1 = 8 
Ex2 = 20
Var1 = 6
Var2 = 17.5
corre = -0.25

r1=-30;
rn=70;
n=100;
r_1 = linspace(r1,rn,n)
r_2 = linspace(r1,rn,n)
sum = 0

cvx_begin
    variables p(100,100)
    P_loss = p(i,j)*r_1(i)*r_2(j) <= 0
    minimize -P_loss
    subject to
    for i=1:100
        for j=1:100
        sum = sum + p(i,j)
        end
    end
    sum == 1; 
    
    for i = 1:100   
        for j= 1:100
            p(i,j) >= 0;
        end
    end
    for i=1:100
        for j=1:100
            P(i) = P(i)+p(i,j)   
        end
        sum0 = sum0 +r_1(i)*P(i) 
        
    end 
    sum0 == 8;
    
    for j=1:100
        for i=1:100
            P(j)=P(j)+p(j,i)
        end
        sum1 = sum1 +r_2(i)*P(j);       
    end
    sum1 == 20;
    
    for i=1:100
        for j=1:100
            sum(r_1(i)*sum(p(j,i))) - 8^2 ==6^2
        end
    end
    
    for i=1:100
        for j=1:100
            sum(r_2(i)*sum(p(i,j))) - 20^2 ==17.5^2
        end
    end
    
    for i=1:100
        for j=1:100
            sum(p(i,j)*r_1(i)*r_2(j)) - 8*20 == -0.25
        end
    end
    
   
cvx_end