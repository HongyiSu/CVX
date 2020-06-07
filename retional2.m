clear all;
 k=201
 t = cal_t(1:201);
e_yes = 0.0234 %e_no = 0.0225 e_yes = 0.0234
 cvx_begin
        variables a0 a1 a2 b1 b2
        minimize 0
        subject to
        for i=1:k
            tt = [1 t(i) t(i)^2] ;
            [1 b1 b2]*tt'>= 0;
            [a0 a1 a2]*tt'-exp(t(i))*[1 b1 b2]*tt'<= e_yes*[1 b1 b2]*tt';
            -[a0 a1 a2]*tt'+exp(t(i))*[1 b1 b2]*tt'<= e_yes*[1 b1 b2]*tt' ;
        end  
cvx_end