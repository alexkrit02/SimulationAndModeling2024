%ALEXANDROS KRITHAROULAS (AEM:10545)
%THEMA 4i ERGASIAS 2
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS


clear;
clc;
close all; 

theta_1 = 0.5;
theta_2 = 2;
a_m = 0.1;

f = @(x) 0.5 * sin(x)*x;
u = @(t)((1/2)*sin(2*pi*t)*exp(1)^(-3*t));

t= 0:0.01:100;
% Ektimish parametrwn me xrhsh ektimhth mikths domhs

% Choose g1,g2
g1_range = [150,200,230,260,290,320,350,400,450,500,600];
g2_range = [150,200,230,260,290,320,350,400,450,500,600];
[g1,g2] = best_g(1,theta_1,theta_2,g1_range,g2_range,u,t,a_m); 

odefun = @(t,x) [-theta_1*(f(x(1)))+ theta_2*u(t);
                     -g1*(x(1)-x(4))*(f(x(1)));
                      g2*(x(1)-x(4))*u(t);
                      -x(2)*(f(x(1)))+x(3)*u(t)+a_m*(x(1)-x(4))];
[t,x] = ode45(odefun,t,[0,0,0,0]);

 figure();
        hold on;
        plot(t, x(:,1));
        plot(t, x(:,4));
        hold off
        grid on;
        xticks(0:5:100)
        title(' $x$ and $\hat{x}$ ','interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        legend('$x$', '$\hat{x}$','interpreter','latex','FontSize',25);

         figure()
        plot(t,x(:,1)- x(:,4));
        title('e = $x$ - $\hat{x}$ without noise','interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:100)
        title(' e= $x$ - $\hat{x}$ ','interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        
     figure()
        subplot(2,1,1)
        hold on;
        plot(t,x(:,2));
        yline(0.5);
        hold off
        title('$theta1$ and $\hat{theta1}$ ','interpreter','latex','FontSize',20);
        legend('$\hat{theta1}$','$theta1_{real}$','interpreter','latex');
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:100)

        subplot(2,1,2)
        hold on;
        plot(t,x(:,3));
        yline(2);
        hold off
        title('$theta2$ and $\hat{theta2}$', 'interpreter','latex','FontSize',20);
        legend('$\hat{theta2}$ ','$theta2_{real}$','interpreter','latex');
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:100)
  