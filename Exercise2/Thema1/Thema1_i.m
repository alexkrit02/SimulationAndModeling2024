%ALEXANDROS KRITHAROULAS (AEM:10545)
%THEMA 1-i ERGASIAS 2
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS

clc;
close all; 

a=2;
b=5;
u=5;
t=0:0.01:30;

% find optimal gamma
g=[1,10,20,30,40];
am=5;
figure()

for i=1:length(g)
   odefun=@(t,x)[-a*x(1)+b*u
                 g(i)*x(4)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 g(i)*x(5)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 -am*x(4)+x(1)
                 -am*x(5)+u
                 x(2)*x(6)-am*x(6)+x(3)*u];
   [t,x]=ode45(odefun,t,[0,0,0,0,0,0]);
   x_re=x(:,1);
   x_hat=x(:,6);
   e=x_re-x_hat;

   subplot(length(g), 1, i); 
   plot(t, e); 
    
   
   xticks(0:5:30)
   grid on;
   title(['e = x - $\hat{x}$ for gamma=', num2str(g(i))],'interpreter','latex','FontSize',25);
   xlabel('Time [s]','FontSize',15);
   ylabel('e = x - $\hat{x}$','interpreter','latex','FontSize',15);
 end
 
 %find optimal am

 g=20;
 am=[1,4,4.3,4.5,5,5.5];

figure()

 for i=1:length(am)
   odefun=@(t,x)[-a*x(1)+b*u
                 g*x(4)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 g*x(5)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 -am(i)*x(4)+x(1)
                 -am(i)*x(5)+u
                 x(2)*x(6)-am(i)*x(6)+x(3)*u];
   [t,x]=ode45(odefun,t,[0,0,0,0,0,0]);
   
   a_hat=am(i)-x(:,2);
   b_hat=x(:,3);

  subplot(length(am), 1, i);
    hold on
    plot(t, a_hat);
    plot(t, b_hat, '-r');
    yline(2, '--b');
    yline(5, '--r');
    hold off;
    grid on;
    xticks(0:5:30)
    title(['$\hat{a}$ and $\hat{b}$ for $a_{m}$ = ', num2str(am(i))], 'interpreter', 'latex', 'FontSize', 15);
    xlabel('Time [s]', 'FontSize', 12);
    legend('$\hat{a}$', '$\hat{b}$', 'a', 'b', 'interpreter', 'latex', 'FontSize', 12);

 end

 %estimate parameters a,b
 g=20;
 am=4.3;

 odefun=@(t,x)[-a*x(1)+b*u
                 g*x(4)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 g*x(5)*(x(1)-(x(2)*x(4)+x(3)*x(5)))
                 -am*x(4)+x(1)
                 -am*x(5)+u
                 x(2)*x(6)-am*x(6)+x(3)*u];
 [t,x]=ode45(odefun,t,[0,0,0,0,0,0]);

 a_hat = am - x(:,2);
 b_hat = x(:,3);
 x_real = x(:,1);
 x_hat = x(:,6);
 e = x_real - x_hat;

 figure()
hold on;
plot(t,x_real);
plot(t,x_hat);
hold off;
grid on;
xticks(0:5:60)
title(['Plot of $x$ and $\hat{x}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x$','$\hat{x}$','interpreter','latex');

% plot a and b and their predictions
figure()
hold on
plot(t,a_hat);
plot(t,b_hat,'-r');
yline(2,'--b');
yline(5,'--r');
hold off;
grid on;
xticks(0:5:60)
title(['$\hat{a}$ and $\hat{b}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$\hat{a}$','$\hat{b}$','$a_{real}$','$b_{real}$','interpreter','latex');

%plot e = x - x_pred
figure()
plot(t,e)
xticks(0:5:60)
grid on;
title(['e = x - $\hat{x}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
ylabel('e = x - $\hat{x}$','interpreter','latex','FontSize',15);




