clear all

rad = 38*pi/180;

%Initial Guess
[t1,t2,t3] = deal(1,5,1);
array(1,:) = [t1 t2 t3];

for i=2:200
    
    t1 = acos((23.1 - 10*cos(t1+t2) - 15*cos(rad))/5);
    t1 = mod(t1,2*pi);
    
    t2 = asin((10.4 - 5*sin(t1) - 15*sin(rad))/10) - t1;
    t2 = mod(t2,2*pi);
    
    t3 = rad - t1 - t2;
    t3 = mod(t3,2*pi);
    
    array(i,:) = deal([t1 t2 t3]);
    
    relative_error = (array(i-1,:) - array(i,:))./array(i-1,:);
    if (abs(max(relative_error)) < 0.001)
        break
    end
end

if (i==200)
    disp('Diverged')
else
    disp(array(i,:))

end