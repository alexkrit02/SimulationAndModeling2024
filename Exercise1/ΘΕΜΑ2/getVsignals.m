function [y1RealError,y2RealError, Vout] = getVsignals(t,flag)

l = length(t);

Vout = zeros(length(t),2);
for i = 1:l
    Vout(i,:) = v(t(i));
end
y2RealError  = Vout(:,2); % Defining VR
y1RealError  = Vout(:,1); % Defining VC

% in case we want to get wrong values in order to observe the model's
% behaviour
if (flag == 1)
% random values between 500 and 1500
a = 500;
b = 1500;

% randi(l) generates a random integer between 1 and l (length of the time matrix)
 for i=1:3 
     y1RealError(randi(l)) = (b-a)*rand() + a;
     y2RealError(randi(l)) = (b-a)*rand() + a;
 end
end

end