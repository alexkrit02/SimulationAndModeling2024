%ALEXANDROS KRITAROULAS (AEM:10545)
%THEMA 1 ERGASIAS 1
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS

clear;
clc;
close all; 

m=8.5;
k=2;
b=0.65;
u=@(t)10*cos(0.5*pi*t)+3;

odefun = @(t,y) [y(2); -b*y(2)/m - k*y(1)/m + u(t)/m];

t=0:0.1:10;

[t,y]=ode45(odefun,t,[0,0]);


Y = y(:,1);
figure;
subplot(1,3,1)
plot(t,Y, 'b')
hold on; 


[estm, estb, estk, esttheta, ymodel] = LeastSquare(y, u, t);

% Εμφάνιση των γραφικών παραστάσεων
subplot(1,3,2)
plot(t, Y, 'b', t, ymodel(:, 1), 'r');
xlabel('Time (s)');
ylabel('Position (m)');
legend('Actual', 'Estimated');
title('Position vs. Time');

% Υπολογισμός της διαφοράς y(t) - y^(t)
error = Y - ymodel(:, 1);

% Εμφάνιση του διαγράμματος
subplot(1,3,3)
plot(t, error, 'm');
xlabel('Time (s)');
ylabel('Error (m)');
title('Error between Actual and Estimated Position');     
