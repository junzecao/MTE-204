clear all
%%
%The largest value for delta_t is 0.21
%or it will diverge
dt = 0.2;
[dx,dy] = deal(0.001);
% delta_t = 0.2;
% delta_x = 0.001;
% delta_y = 0.001;
T_init = 80;
T_target = 57.80;

radius = 0.0445;
height = 0.0700;

A = zeros(round(height/dy)+1,round(radius/dx)+1);
A(:) = T_init;
count = 0;
while max(max(A))>=T_target
    A = stiffness_centre(A,dt,dx,dy);
    count = count+1;
    if max(max(A))>T_init+5
        disp('Diverged')
        break
    end
end
fprintf('%.f s\n',count*dt)

%%
contourf(A(round(height/dy)+1:-1:1,:))
colormap(hot)
colorbar
xlabel('radius (mm)')
ylabel('height (mm)')
title('Contour plot');