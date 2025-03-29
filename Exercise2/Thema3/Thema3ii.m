%ALEXANDROS KRITHAROULAS (AEM:10545)
%THEMA 3ii ERGASIAS 2
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS

clear;
clc;
close all; 

a11 = -1;
a12 = 1;
a21 = -4;
a22 = 0;
b1 = 2;
b2 = 1;
theta_m=0.1;

u = @(t)(4*sin(pi*t) + 2*sin(8*pi*t));

t= 0:0.001:30;
% Ektimish parametrwn me xrhsh ektimhth parallhlhs domhs

% Choose g1,g2
g1_range = [20,25,30,40,50];
g2_range = [20,25,30,40,50];
[g1,g2] = best_g(2,a11,a12,a21,a22,b1,b2,g1_range,g2_range,u,t,theta_m);

odefun = @(t,y) [a11*y(1) + a12*y(2) + b1*u(t);
                a21*y(1) + a22*y(2) + b2*u(t);
                g1*y(1)*(y(1)-y(9));
                g1*y(2)*(y(1)-y(9));
                g1*y(1)*(y(2)-y(10));
                g1*y(2)*(y(2)-y(10));
                g2*u(t)*(y(1)-y(9));
                g2*u(t)*(y(2)-y(10));
                y(3)*y(9) + y(4)*y(10) + y(7)*u(t) + theta_m*(y(1)-y(9));
                y(5)*y(9) + y(6)*y(10) + y(8)*u(t) + theta_m*(y(2)-y(10));
                ];
[t,y] = ode45(odefun,t,[0,0,0,0,0,0,0,0,0,0]);

% plot x1,x2 and x1_pred,x2_pred
figure()
subplot(2,1,1)
hold on;
plot(t,y(:,1));
plot(t,y(:,9));
hold off
grid on;
xticks(0:5:30)
title('[Mixed structure] $x_1$ and $\hat{x_1}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x_1$','$\hat{x_1}$','interpreter','latex','FontSize',25);

subplot(2,1,2)
hold on;
plot(t,y(:,2));
plot(t,y(:,10));
hold off
grid on;
xticks(0:5:30)
title('[Mixed structure] $x_2$ and $\hat{x_2}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x_2$','$\hat{x_2}$','interpreter','latex','FontSize',25);
%saveas(gcf, "x1_x2.pdf");

%plot e1 and e2
figure()
subplot(2,1,1)
plot(t,y(:,1)- y(:,9));
title('[Mixed structure] $e_1$ = $x_1$ - $\hat{x_1}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;
xticks(0:5:30)
dim = [.55 .6 .35 .07];
MAE = (sum(abs(y(:,1)- y(:,9))))/length(y); %mean absolute error
str = strcat('Mean Absolute Error =',num2str(MAE));
annotation('textbox',dim,'String',str,'FontSize',12)

subplot(2,1,2)
plot(t,y(:,2)- y(:,10));
title('[Mixed structure] $e_2$ = $x_2$ - $\hat{x_2}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;
xticks(0:5:30)
dim = [.55 .125 .35 .07];
MAE = (sum(abs(y(:,2)- y(:,10))))/length(y); %mean absolute error
str = strcat('Mean Absolute Error =',num2str(MAE));
annotation('textbox',dim,'String',str,'FontSize',12)
%saveas(gcf, "e1_e2.pdf");

%plot a11,a12,a21,a22
figure()
%a11
subplot(2,2,1)
hold on;
plot(t,y(:,3));
yline(a11,'-k');
hold off
title('[Mixed structure] $a_{11}$ and $\hat{a_{11}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{11}}$','real $a_{11}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30)

%a12
subplot(2,2,2)
hold on;
plot(t,y(:,4));
yline(a12,'-k');
hold off
title('[Mixed structure] $a_{12}$ and $\hat{a_{12}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{12}}$','real $a_{12}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30)


%a21
subplot(2,2,3)
hold on;
plot(t,y(:,5));
yline(a21,'-k');
hold off
title('[Mixed structure] $a_{21}$ and $\hat{a_{21}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{21}}$','real $a_{21}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30)

%a22
subplot(2,2,4)
hold on;
plot(t,y(:,6));
yline(a22,'-k');
hold off
title(' [Mixed structure] $a_{22}$ and $\hat{a_{22}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{22}}$','real $a_{22}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30);


%plot b1,b2
figure()
%b1
subplot(2,1,1)
hold on;
plot(t,y(:,7));
yline(b1,'-k');
hold off
title('[Mixed structure] $b_1$ and $\hat{b_1}$','interpreter','latex','FontSize',20);
legend('$\hat{b_1}$','real $b_1$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30)

%b2
subplot(2,1,2)
hold on;
plot(t,y(:,8));
yline(b1,'-k');
hold off
title('[Mixed structure] $b_2$ and $\hat{b_2}$','interpreter','latex','FontSize',20);
legend('$\hat{b_2}$','real $b_2$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:30)


