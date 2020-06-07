k=201
e_yes = 1;
e_no = 0;

t = cal_t(1:201);

while e_yes - e_no > 0.001 % accuracy = 0.001
    e_maybe = (e_yes + e_no)/2
    cvx_begin
        variables a0 a1 a2 b1 b2
        minimize 0
        subject to
        for i=1:k
            tt = [1 t(i) t(i)^2] ;
            [1 b1 b2]*tt'>= 0;
            [a0 a1 a2]*tt'-exp(t(i))*[1 b1 b2]*tt'<= e_maybe*[1 b1 b2]*tt';
            -[a0 a1 a2]*tt'+exp(t(i))*[1 b1 b2]*tt'<= e_maybe*[1 b1 b2]*tt' ;
            
        end  
    cvx_end
        
        strcmp(cvx_status,'Solved')
        if strcmp(cvx_status,'Solved')
            e_yes = e_maybe;
            e_maybe
        else 
            e_no = e_maybe;
        end
end
e_maybe



function [w] = cal_t(i)
    w = -3+6*(i-1)/200
end