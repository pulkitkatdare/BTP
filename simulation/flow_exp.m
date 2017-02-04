function [X_f,theta1,theta2] = flow_exp(X_i,t,input_alpha1,input_alpha2,G_1,G_2,dt,theta1,theta2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
syms alpha_1 alpha_2 L
%dt = 0.001;
no_ofsteps = t/dt;
%X_f = X_i;
%theta1 = 0;%X_f(4);
%theta2 = 0;%X_f(5);
final_M =X_i;%[cos(X_f(3)) sin(X_f(3)) X_f(1) ; -sin(X_f(3)) cos(X_f(3)) X_f(2) ; 0 0 1];
for i = 1:no_ofsteps
g_1 = input_alpha1*double(subs(G_1,[alpha_1,alpha_2,L],[theta1,theta2,0.068/2]));
g_2 = input_alpha2*double(subs(G_2,[alpha_1,alpha_2,L],[theta1,theta2,0.068/2]));%0.068/2
X_dot = (g_1 + g_2)*dt;
matrix = [0 X_dot(3) X_dot(1) ; -X_dot(3) 0 X_dot(2) ; 0 0 0];
final_M = expm(matrix)*final_M;
theta1 = dt*(g_1(4)+g_2(4)) + theta1; 
theta2 = dt*(g_1(5)+g_2(5)) + theta2; 
end
X_f = final_M;
end

