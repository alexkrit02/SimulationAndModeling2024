function [g1_best,g2_best] = best_g(choose,a11,a12,a21,a22,b1,b2,g1,g2,u,t,theta_m)
   if choose==1
    min = 1;
    for i = 1:length(g1)
        for j = 1:length(g2)
            odefun = @(t,y) [a11*y(1) + a12*y(2) + b1*u(t);
                a21*y(1) + a22*y(2) + b2*u(t);
                g1(i)*y(9)*(y(1)-y(9));
                g1(i)*y(10)*(y(1)-y(9));
                g1(i)*y(9)*(y(2)-y(10));
                g1(i)*y(10)*(y(2)-y(10));
                g2(j)*u(t)*(y(1)-y(9));
                g2(j)*u(t)*(y(2)-y(10));
                y(3)*y(9) + y(4)*y(10) + y(7)*u(t);
                y(5)*y(9) + y(6)*y(10) + y(8)*u(t);
                ];
            [t,y] = ode45(odefun,t,[0,0,0,0,0,0,0,0,0,0]);
            MAE = (sum(abs(y(:,1)- y(:,9))))/length(y); %mean absolute error
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end 
    end
    fprintf("Best pair: [g1,g2] = [%d,%d] for parralel structure\n",g1_best,g2_best);
   end
   if choose==2
       min=1;
       for i = 1:length(g1)
           for j = 1:length(g2)
               odefun = @(t,y) [a11*y(1) + a12*y(2) + b1*u(t);
                a21*y(1) + a22*y(2) + b2*u(t);
                g1(i)*y(1)*(y(1)-y(9));
                g1(i)*y(2)*(y(1)-y(9));
                g1(i)*y(1)*(y(2)-y(10));
                g1(i)*y(2)*(y(2)-y(10));
                g2(j)*u(t)*(y(1)-y(9));
                g2(j)*u(t)*(y(2)-y(10));
                y(3)*y(9) + y(4)*y(10) + y(7)*u(t)+theta_m*(y(1)-y(9));
                y(5)*y(9) + y(6)*y(10) + y(8)*u(t)+theta_m*(y(2)-y(10));
                ];
            [t,y] = ode45(odefun,t,[0,0,0,0,0,0,0,0,0,0]);
            MAE = (sum(abs(y(:,1)- y(:,9))))/length(y); %mean absolute error
            if MAE < min
                min = MAE;
                g1_best = g1(i);
                g2_best = g2(j);
            end
        end 
    end
    fprintf("Best pair: [g1,g2] = [%d,%d] for mixed structure\n",g1_best,g2_best);
   end