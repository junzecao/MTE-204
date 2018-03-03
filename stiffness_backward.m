function B = stiffness_backward( T , dt , dx, dy)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

T_air = 25;
h = -30;
th_container = 0.002;

k_liquid = 0.647;
k_container = 0.050;

c_liquid = 4200;
c_container = 1336;

p_liquid = 1000;
p_container = 1201;

k_cbm = 2/(1/k_liquid + 1/k_container);
c_cbm = 2/(1/c_liquid + 1/c_container);
p_cbm = 2/(1/p_liquid + 1/p_container);

%x and y are in terms of the MATLAB coordinates
[y,x] = size(T);
B = zeros(y,x);
coef = p_cbm*c_cbm*dx*dy/dt;

% Corner Node A
B(1,x) = ...
    -k_liquid*(T(1,x)-T(1,x-1))*dy/dx...
    -k_container*(T(1,x)-T_air)*dy/th_container...
    -k_liquid*(T(1,x)-T(2,x))*dx/dy...
    -h*(T_air-T(1,x))*dx;
B(1,x) = B(1,x)/coef + T(1,x);

%Corner Node B
B(y,x) = ...
    -k_cbm*(T(y,x)-T(y,x-1))*dy/dx...
    -k_container*(T(y,x)-T_air)*dy/th_container...
    -k_liquid*(T(y,x)-T(y-1,x))*dx/dy;
B(y,x) = B(y,x)/coef + T(y,x);

%Corner Node C - unchanged(centre)
B(1,1) = ...
    -2*k_liquid*(T(1,1)-T(1,2))*dy/dx...
    -k_liquid*(T(1,1)-T(2,1))*dx/dy...
    -h*(T_air-T(1,1))*dx;
B(1,1) = B(1,1)/coef + T(1,1);

%Corner Node D - unchanged(centre)
B(y,1) = ...
    -k_liquid*(T(y,1)-T(y-1,1))*dx/dy...
    -2*k_cbm*(T(y,1)-T(y,2))*dy/dx;
B(y,1) = B(y,1)/coef + T(y,1);

%Equation 1 + 4 - unchanged(centre) + Column right of 4
for i=2:y-1
    B(i,x) = ...
        -k_liquid*(T(i,x)-T(i,x-1))*dy/dx...
        -k_container*(T(i,x)-T_air)*dy/th_container...
        -k_cbm*(T(i,x)-T(i+1,x))*dx/dy...
        -k_cbm*(T(i,x)-T(i-1,x))*dx/dy;
    B(i,x) = B(i,x)/coef + T(i,x);
    
    B(i,1) = ...
        -2*k_liquid*(T(i,1)-T(i,2))*dy/dx...
        -k_liquid*(T(i,1)-T(i+1,1))*dx/dy...
        -k_liquid*(T(i,1)-T(i-1,1))*dx/dy;
    B(i,1) = B(i,1)/coef + T(i,1);
    
    B(i,2) = ...
        -k_liquid*(T(i,2)-T(i,1))*dy/dx...
        -k_liquid*(T(i,2)-T(i,3))*dy/dx...
        -k_liquid*(T(i,2)-T(i-1,2))*dx/dy...
        -k_liquid*(T(i,2)-T(i+1,2))*dx/dy;
    B(i,2) = B(i,2)/coef + T(i,2);
end
    
%Equation 2 + 3 + Row above 2
for i=2:x-1
    B(y,i) = ...
        -k_cbm*(T(y,i)-T(y,i-1))*dy/dx...
        -k_cbm*(T(y,i)-T(y,i+1))*dy/dx...
        -k_liquid*(T(y,i)-T(y-1,i))*dx/dy;
    B(y,i) = B(y,i)/coef + T(y,i);
    
    B(1,i) = ...
        -k_liquid*(T(1,i)-T(1,i-1))*dy/dx...
        -k_liquid*(T(1,i)-T(1,i+1))*dy/dx...
        -k_liquid*(T(1,i)-T(2,i))*dx/dy...
        -h*(T_air-T(1,i))*dx;
    B(1,i) = B(1,i)/coef + T(1,i);
    
    B(y-1,i) = ...
        -k_liquid*(T(y-1,i)-T(y-1,i-1))*dy/dx...
        -k_liquid*(T(y-1,i)-T(y-1,i+1))*dy/dx...
        -k_liquid*(T(y-1,i)-T(y-2,i))*dx/dy...
        -k_liquid*(T(y-1,i)-T(y,i))*dx/dy;
    B(y-1,i) = B(y-1,i)/coef + T(y-1,i);
end

for i=2:y-2
    for j=3:x-1
        B(i,j) = ...
            -k_liquid*(T(i,j-1)-T(i,j))*dy/dx...
            -k_liquid*(T(i,j-1)-T(i,j-2))*dy/dx...
            -k_liquid*(T(i+1,j)-T(i,j))*dx/dy...
            -k_liquid*(T(i+1,j)-T(i+2,j))*dx/dy;
        B(i,j) = B(i,j)/coef + T(i,j);
    end
end

end
