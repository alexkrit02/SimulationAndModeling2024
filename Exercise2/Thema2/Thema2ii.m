%ALEXANDROS KRITHAROULAS (AEM:10545)
%THEMA 2i ERGASIAS 2
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS

clear;
clc;
close all;

a = 2;
b = 5;
h0 = 0.5;
theta_m = 0.1;
t= 0:0.01:30;

u = @(t) (5*sin(2*t));

g1_range = [10, 15, 20, 25, 30];
g2_range = [10, 15, 20, 25, 30];

freqs = [ 10,20, 40,80 ,120];  % Ορίζουμε τις τιμές της συχνότητας που επιθυμούμε

for f = freqs
    h = @(t) h0*sin(2*pi*f*t);

    [g1, g2] = best_g(2, a, b, theta_m, g1_range, g2_range, u, t,f);

    odefun1 = @(t,x) [-a*x(1) + b*u(t);
                     -g1*(x(1)-x(4))*x(1);
                      g2*(x(1)-x(4))*u(t);
                      -x(2)*x(4)+x(3)*u(t)+theta_m*(x(1)-x(4))];
    odefun2 = @(t,x) [-a*x(1) + b*u(t);
                     -g1*(x(1)+h(t)-x(4))*(x(1));
                      g2*(x(1)+h(t)-x(4))*u(t);
                     -x(2)*x(4)+x(3)*u(t)+theta_m*(x(1)+h(t)-x(4))];
    [t,x] = ode45(odefun1,t,[0,0,0,0]);
    [t, x_noise] = ode45(odefun2, t, [0, 0, 0, 0]);

    MAE = (sum(abs(x(:,1)-x(:,4))))/length(x);  % Μέσος Απόλυτος Σφάλματος
    MAE_noise = (sum(abs(x_noise(:,1)-x_noise(:,4))))/length(x_noise);  % Μέσος Απόλυτος Σφάλματος με Θόρυβο
     fprintf("[Mixed Structure] f = %d and h = %d: Mean Absolute Error = %f\n", f, h0, MAE_noise);
    if f == 40
        
        % Δημιουργία των διαγραμμάτων

        figure;

        % Αρχικός και προβλεπόμενος x με και χωρίς θόρυβο
        subplot(2,1,1)
        hold on;
        plot(t, x(:,1));
        plot(t, x(:,4));
        hold off
        grid on;
        xticks(0:5:30)
        title('[Parallel structure] $x$ and $\hat{x}$ without noise','interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        legend('$x$', '$\hat{x}$','interpreter','latex','FontSize',25);

        subplot(2,1,2)
        hold on;
        plot(t, x_noise(:,1));
        plot(t, x_noise(:,4));
        hold off
        grid on;
        xticks(0:5:30)
        title({'[Parallel structure] $x$ and $\hat{x}$ with noise';['$f =$ ', num2str(f), ', $h_0 =$ ', num2str(h0)]},'interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        legend('$x$', '$\hat{x}$','interpreter','latex','FontSize',25);

        % e = x - x_pred with and without noise
        figure()
        subplot(2,1,1)
        plot(t,x(:,1)- x(:,4));
        title('[Parallel structure] e = $x$ - $\hat{x}$ without noise','interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:30)
        dim = [.55 .6 .35 .07];
        str = strcat('Mean Absolute Error =',num2str(MAE));
        annotation('textbox',dim,'String',str,'FontSize',12)

        subplot(2,1,2)
        plot(t,x_noise(:,1)- x_noise(:,4));
        title({'[Parallel structure] e = $x$ - $\hat{x}$ with noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',25);
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:30)
        dim = [.55 .125 .35 .07];
        str = strcat('Mean Absolute Error =',num2str(MAE_noise));
        annotation('textbox',dim,'String',str,'FontSize',12)

        % a and b with and without noise
        figure()
        subplot(2,1,1)
        hold on;
        plot(t,x_noise(:,2));
        plot(t,x(:,2));
        yline(1.5,'-k');
        hold off
        title({'[Parallel structure] a and $\hat{a}$ with and without noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',20);
        legend('$\hat{a}$ with noise','$\hat{a}$ without noise','$a_{real}$','interpreter','latex');
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:30)

        subplot(2,1,2)
        hold on;
        plot(t,x_noise(:,3));
        plot(t,x(:,3));
        yline(2,'-k');
        hold off
        title({'[Parallel structure] b and $\hat{b}$ with and without noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',20);
        legend('$\hat{b}$ with noise','$\hat{b}$ without noise','$b_{real}$','interpreter','latex');
        xlabel('Time [s]','FontSize',15);
        grid on;
        xticks(0:5:30)
    end
end

h0 = [0.5,0.75,1];
f=40;

for h0=h0
    h = @(t) h0*sin(2*pi*f*t);

    [g1, g2] = best_g(2, a, b, theta_m, g1_range, g2_range, u, t,f);

    odefun1 = @(t,x) [-a*x(1) + b*u(t);
                     -g1*(x(1)-x(4))*x(1);
                      g2*(x(1)-x(4))*u(t);
                      -x(2)*x(4)+x(3)*u(t)+theta_m*(x(1)-x(4))];

    odefun2 = @(t,x) [-a*x(1) + b*u(t);
                     -g1*(x(1)+h(t)-x(4))*(x(1)+h(t));
                      g2*(x(1)+h(t)-x(4))*u(t);
                     -x(2)*x(4)+x(3)*u(t)+theta_m*(x(1)+h(t)-x(4))];
    options = odeset('RelTol',1e-10,'AbsTol',1e-12);

    [t, x] = ode113(odefun1, t, [0, 0, 0, 0], options);

    
    [t, x_noise] = ode113(odefun2, t, [0, 0, 0, 0], options);


    MAE = (sum(abs(x(:,1)-x(:,4))))/length(x);  % Μέσος Απόλυτος Σφάλματος
    MAE_noise = (sum(abs(x_noise(:,1)-x_noise(:,4))))/length(x_noise);  % Μέσος Απόλυτος Σφάλματος με Θόρυβο
     fprintf("[Mixed Structure] f = %d and h = %d: Mean Absolute Error = %f\n", f, h0, MAE_noise);
end