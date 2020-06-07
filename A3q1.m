cvx_begin
    variables x y 
	minimize x+y
    subject to
        2*x+y>=1;
        x+3*y>=1;
        x>=0;
        y>=0;
cvx_end 

cvx_begin
    variables x y 
	minimize x^2+9*y^2
    subject to
        2*x+y>=1;
        x+3*y>=1;
        x>=0;
        y>=0;
cvx_end 
