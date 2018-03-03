clear all

%The smallest value for delta_t is 0.21
%or it will diverge
dt = 1;
dx = 0.001;
dy = 0.001;
T_init = 80;
T_target = 57.80;

radius = 0.0445;
height = 0.0700;

A = zeros(round(height/dy)+1,round(radius/dx)+1);
A(:) = T_init;
count = 0;
while max(max(A))>=T_target
    A = stiffness_backward(A,dt,dx,dy);
    count = count+1;
    if max(max(A))>T_init+10
        disp('Diverged')
        break
    end
end

fprintf('%.f s\n',count*dt)