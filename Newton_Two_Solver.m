function x = Newton_Two_Solver( A,b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (~A(1,1))
    row_temp = A(1,1:3);
    b_temp = b(1);
    if (A(2,1))
        A(1,1:3) = A(2,1:3);
        A(2,1:3) = row_temp;
        b(1) = b(2);
        b(2) = b_temp;
    elseif (A(3,1))
        A(1,1:3) = A(3,1:3);
        A(3,1:3) = row_temp;
        b(1) = b(3);
        b(3) = b_temp;
    end
end

a21 = A(2,1) / A(1,1);
a31 = A(3,1) / A(1,1);

A(2,1:3) = A(2,1:3) - a21*A(1,1:3);
b(2) = b(2) - a21*b(1);
A(3,1:3) = A(3,1:3) - a31*A(1,1:3);
b(3) = b(3) - a31*b(1);

A(2:3,1) = 0;

if (~A(2,2))
    row_temp = A(2,1:3);
    b_temp = b(2);
    
    A(2,1:3) = A(3,1:3);
    A(3,1:3) = row_temp;
    b(2) = b(3);
    b(3) = b_temp;
end

a32 = A(3,2) / A(2,2);
A(3,1:3) = A(3,1:3) - a32*A(2,1:3);
b(3) = b(3) - a32*b(2);

A(3,2) = 0;

x(3) = b(3)/A(3,3);
x(2) = (b(2) - A(2,3)*x(3))/A(2,2);
x(1) = (b(1) - A(1,2)*x(2) - A(1,3)*x(3))/A(1,1);
x = x.';


end

