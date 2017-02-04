function X_f = flow(X_i,t,input_alpha1,input_alpha2,G_1,G_2,dt)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
syms alpha_1 alpha_2 L
%dt = 0.001;
no_ofsteps = t/dt;
X_f = X_i;
for i = 1:no_ofsteps
g_1 = input_alpha1*double(subs(G_1,[alpha_1,alpha_2,L],[X_f(4),X_f(5),0.068/2]));
g_2 = input_alpha2*double(subs(G_2,[alpha_1,alpha_2,L],[X_f(4),X_f(5),0.068/2]));%0.068/2
X_f = X_f + dt*(g_1 + g_2);
X_f = X_f + dt*(g_1 + g_2);
end
end

