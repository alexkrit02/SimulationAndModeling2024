function [g1_best,g2_best]=best_g(choose,theta_1,theta_2,g1,g2,u,t,a_m) 
if choose==1
    f = @(x) 0.5 * sin(x)*x;
   min = 1;
    for i = 1:length(g1)
        for j = 1:length(g2)
            odefun = @(t,x) [-theta_1*(f(x(1)))+ theta_2*u(t);
                     -g1(i)*(x(1)-x(4))*(f(x(1)));
                      g2(j)*(x(1)-x(4))*u(t);
                      -x(2)*(f(x(1)))+x(3)*u(t)+a_m*(x(1)-x(4))];
            [t,x] = ode45(odefun,t,[0,0,0,0]);
            MAE = (sum(abs(x(:,1)- x(:,4))))/length(x); 
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end
    end
    fprintf("Best pair: [g1,g2] = [%d,%d]\n",g1_best,g2_best);
end
if choose==2
    f = @(x) (-0.25 *x^2) ;
    min = 1;

    for i = 1:length(g1)
        for j = 1:length(g2)
           odefun = @(t,x) [-theta_1*(f(x(1)))+ theta_2*u(t);
                     -g1(i)*(x(1)-x(4))*(f(x(1)));
                      g2(j)*(x(1)-x(4))*u(t);
                      -x(2)*(f(x(1)))+x(3)*u(t)+a_m*(x(1)-x(4))];
            [t,x] = ode45(odefun,t,[0,0,0,0]);
            MAE = (sum(abs(x(:,1)- x(:,4))))/length(x); 
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end
    end
    fprintf("Best pair: [g1,g2] = [%d,%d]\n",g1_best,g2_best);
end

   