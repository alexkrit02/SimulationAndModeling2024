function [g1_best,g2_best]=best_g(choose,a,b,theta_m,g1,g2,u,t,f)
if choose == 1  
    min = 1;
    for i = 1:length(g1)
        for j = 1:length(g2)
            odefun = @(t,x) [-a*x(1)+ b*u(t);
                     -g1(i)*(x(1)-x(4))*x(4);
                      g2(j)*(x(1)-x(4))*u(t);
                      -x(2)*x(4)+x(3)*u(t)];
            [t,x] = ode45(odefun,t,[0,0,0,0]);
            MAE = (sum(abs(x(:,1)- x(:,4))))/length(x); 
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end 
    end
    fprintf("Best pair: [g1,g2] = [%d,%d] for f=%d \n",g1_best,g2_best,f);
end
if choose == 2
   
    min = 1;
    for i = 1:length(g1)
        for j = 1:length(g2)
            odefun = @(t,x) [-a*x(1)+ b*u(t);
                     -g1(i)*(x(1)-x(4))*x(1);
                      g2(j)*(x(1)-x(4))*u(t);
                      -x(2)*x(4)+x(3)*u(t)+theta_m*(x(1)-x(4))];
            [t,x] = ode45(odefun,t,[0,0,0,0]);
            MAE = (sum(abs(x(:,1)- x(:,4))))/length(x); 
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end
    end
    fprintf("Best pair: [g1,g2] = [%d,%d] for f=%d\n",g1_best,g2_best,f);
end
end