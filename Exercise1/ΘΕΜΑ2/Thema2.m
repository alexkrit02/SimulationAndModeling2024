%ALEXANDROS KRITAROULAS (AEM:10545)
%THEMA 2 ERGASIAS 1
%ΜODELING AND SIMULATION OF DYNAMIC SYSTEMS

clear;
clc;
close all; 

u1 = @(t) 3*sin(pi*t);
u2 = 2.5; 

tstart = 0;
step = 0.00001;
tend = 8;
t = tstart:step:tend;


% Get correct values for VC and VR + LS
flag = 0;
[y1Real,y2Real,Vout] = getVsignals(t,flag);

[theta,y1model] = LeastSquare(y1Real,t,u1,u2);

y2model = (u1(t))' + u2 - y1model;


subplot(1,3,1)
plot(t, y1Real, 'LineWidth', 1.2);
title('Real $V_{C}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{1}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,2)
plot(t, y1model, 'LineWidth', 1.2);
title('Model $V_{C}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{1}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,3)
plot(t, y1Real-y1model, 'LineWidth', 1.2);
title('$e_{V_{C}}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$V_{C,real} - V_{C,model}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)');

figure;
subplot(1,3,1)
plot(t, y2Real, 'LineWidth', 1.2);
title('$Real V_{R}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{2}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,2)
plot(t, y2model, 'LineWidth', 1.2);
title('Model $V_{R}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{2}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,3)
plot(t, y2Real-y2model, 'LineWidth', 1.2);
title('$e_{V_{R}}$', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$V_{R,real} - V_{R,model}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

% Get incorrent values for VC and VR + LS
flag = 1;
[y1RealER,y2RealER,VoutER] = getVsignals(t,flag);

[thetaER,y1modelER] = LeastSquare(y1RealER,t,u1,u2);

y2modelER = (u1(t))' + u2 - y1modelER;

figure;
subplot(1,3,1)
plot(t, y1RealER, 'LineWidth', 1.2);
title('Real $V_{C}$ for incorrect values' , 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{1}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,2)
plot(t, y1modelER, 'LineWidth', 1.2);
title('Model $V_{C}$ for incorrect values', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{1}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,3)
plot(t, y1RealER-y1modelER, 'LineWidth', 1.2);
title('$e_{V_{C}}$ for incorrect values', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$V_{C,real} - V_{C,model}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)');

figure;
subplot(1,3,1)
plot(t, y2RealER, 'LineWidth', 1.2);
title('$Real V_{R}$ for incorrect values', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{2}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,2)
plot(t, y2modelER, 'LineWidth', 1.2);
title('Model $V_{R}$ for incorrect values', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$y_{2}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);

subplot(1,3,3)
plot(t, y2RealER-y2modelER, 'LineWidth', 1.2);
title('$e_{V_{R}}$ for incorrect values', 'Interpreter', 'Latex', 'fontsize', 12);
ylabel('$V_{R,real} - V_{R,model}$', 'Interpreter', 'Latex', 'fontsize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'fontsize', 12);