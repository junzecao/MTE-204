clear all

%x = theta1, y = theta2, z = theta3
syms x y z

f(x,y,z) = [5*sin(x) + 10*sin(x+y) + 15*sin(x+y+z) - 10.4;...
5*cos(x) + 10*cos(x+y) + 15*cos(x+y+z) - 23.1;...
x + y + z - 38*pi/180];

jacobian = [[15*cos(x+y+z) + 10*cos(x+y) + 5*cos(x),15*cos(x+y+z) + 10*cos(x+y),15*cos(x+y+z)];...
    [-15*sin(x+y+z) - 10*sin(x+y) - 5*sin(x), -15*sin(x+y+z) - 10*sin(x+y),-15*sin(x+y+z)];...
    [1,1,1]];

current = [0.2;0.2;0.2];

for i=1:200
    try
        inverse = inv(double(subs(jacobian,[x;y;z],current)));
    catch
        error('Error\nThe inverse does not exist');
    end
    next = current - inverse * double(subs(f,[x;y;z],current));
    
    array(i,1:3) = next.';
    %Set the stop condition to be a relative error of 0.001
    relative_error = (next - current) ./ current;
    current = next;
    if (abs(max(relative_error)) < 0.001)
        break
    end
end

if (i==200)
    disp('Diverged')
else
    answer = mod(next,2*pi);
    disp(answer)
end
