clear
syms k L alpha_1 alpha_2 eta_x eta_y eta_a  dot_alpha_1 dot_alpha_2 theta x y
%eta_1 = [cos(alpha_1)*eta_x - sin(alpha_1)*eta_y + sin(alpha_1)*L*eta_a ; ...
%    sin(alpha_1)*eta_x + cos(alpha_1)*eta_y - (cos(alpha_1) + 1)*L*eta_a + L*dot_alpha_1; ...
%     eta_a - dot_alpha_1] ;
eta = [eta_x ; eta_y ; eta_a];
alpha = [dot_alpha_1  ; dot_alpha_2];
Q = [eta_x ; eta_y ; eta_a ; dot_alpha_1  ; dot_alpha_2];
%eta_3 = [cos(alpha_2)*eta_x + sin(alpha_2)*eta_y + sin(alpha_2)*L*eta_a ; ...
%   -sin(alpha_2)*eta_x + cos(alpha_2)*eta_y + (cos(alpha_2) + 1)*L*eta_a + L*dot_alpha_2 ; ...
%   eta_a + dot_alpha_2];
Meta_1 = [cos(alpha_1) -sin(alpha_1) L*sin(alpha_1) 0 0 ; ...
    sin(alpha_1) cos(alpha_1) -(cos(alpha_1) + 1)*L L 0 ; ...
    0 0 1 -1 0];
Meta_2 = [1 0 0 0 0 ; 0 1 0 0 0 ; 0 0 1 0 0];
Meta_3  = [cos(alpha_2) sin(alpha_2) sin(alpha_2)*L 0 0 ; ...
    -sin(alpha_2) cos(alpha_2) (cos(alpha_2) + 1)*L 0 L ; ...
    0 0 1 0 1];
%F_1 = [k*L*eta_1(1) ; 2*k*L*eta_1(2) ; (2/3)*k*(L^3)*eta_1(3)];
%F_2 = [k*L*eta_2(1) ; 2*k*L*eta_2(2) ; (2/3)*k*(L^3)*eta_2(3)];
%F_3 = [k*L*eta_3(1) ; 2*k*L*eta_3(2) ; (2/3)*k*(L^3)*eta_3(3)];
%MF_1 = [1*L 0 0  ; 0 2*L 0  ; 0 0 (2/3)*1*(L^3)];
MF_1 = [2*0.0213*L 0 0  ; 0 31.8772*2*L 0  ; 0 0 (2/3)*31.8772*2*(L^3)];%
MF_2 = MF_1 ;
MF_3 = MF_1;
T_1 = [cos(alpha_1) sin(alpha_1) 0 ; -sin(alpha_1) cos(alpha_1) 0 ; L*sin(alpha_1) -L*(1 + cos(alpha_1)) 1];%Remove minus in the L*(1 + cos(alpha_1))term
Omega_1 = T_1*MF_1*Meta_1;
%%%%%%%%%%%%%%%%%%%%%%
Omega_2 = MF_2*Meta_2;
T_3 = [cos(alpha_2) -sin(alpha_2) 0 ; sin(alpha_2) cos(alpha_2) 0 ; L*sin(alpha_2) L*(1 + cos(alpha_2)) 1];%Add minus in the L*(1 + cos(alpha_2)) term
Omega_3 = T_3*MF_3*Meta_3;
Omega = Omega_1 + Omega_2 + Omega_3;
ohm_1 = Omega(:,1:3);
ohm_2 = Omega(:,4:5);
ohm = -ohm_1\ohm_2;
Final_A = [ohm ; 1 0 ; 0 1] ;
Q = [x ; y ; theta ; alpha_1  ; alpha_2];
J_1 = jacobian(Final_A(:,1), Q);
J_2 = jacobian(Final_A(:,2), Q);
lie_XY = (-J_1*Final_A(:,2) + J_2*Final_A(:,1)) ;%[A1,A2]
J_3 = jacobian(lie_XY, Q);
lie_1XY = (J_3*Final_A(:,1) - J_1*lie_XY);%[A1,[A1,A2]]
lie_2XY = (J_3*Final_A(:,2) - J_2*lie_XY);%[A2,[A1,A2]]
sol_M = [Final_A lie_XY lie_1XY lie_2XY];
sol_M = double(subs(sol_M,[alpha_1,alpha_2,L],[0,0,0.068/2]));%make changes and put theta_1 and theta_2 values here
inputs_X = sol_M\([1 ; 0 ; 0;0;0]);%inputs_x are your inputs where 3,4,5th term are higher order lie vector fields respectively
inputs_Y = inv(sol_M)*[0 ; 1 ; 0 ; 0 ; 0];
inputs_theta = inv(sol_M)*[0 ; 0 ; 1 ; 0 ; 0];
a = inputs_Y(3);
%a = 1;
b = inputs_Y(4);
c = inputs_Y(5);
t = 10 ;
n = 10;
t = sqrt(t/n);
dt = t/100;
W = sym(zeros(5,1));
X_f = zeros(5,1);
%% X Direction Plot
%{
t = 1 ;
n = 10000;
j =1;
t = sqrt(t/n) ;
dt = t/5 ; %/5
data_x = zeros(5,4*n+1);
theta1 = 0;
theta2 = 0;
X_f = [cos(X_f(3)) sin(X_f(3)) X_f(1) ; -sin(X_f(3)) cos(X_f(3)) X_f(2) ; 0 0 1];

for i = 1:1
    i
    j = j +1;
    [X_f,theta1,theta2] = flow_exp(X_f,t,a,0,Final_A(:,1),W,dt,theta1,theta2);
    %data_x(:,j) = 1000*double(X_f);
    [X_f,theta1,theta2] = flow_exp(X_f,t,0,1,W,Final_A(:,2),dt,theta1,theta2);
    %j = j +1;
    %data_x(:,j) = 1000*double(X_f);
    [X_f,theta1,theta2] = flow_exp(X_f,t,a,0,-Final_A(:,1),W,dt,theta1,theta2);
    %j = j+1;
    %data_x(:,j) = 1000*double(X_f);
    [X_f,theta1,theta2] = flow_exp(X_f,t,0,1,W,-Final_A(:,2),dt,theta1,theta2);
    %j = j + 1;
    %data_x(:,j) = 1000*double(X_f);
    X_f
end
X_f;
%}
%b = 1;
%c = -1;
t = 1 ;
n = 100;
j =1;
t = t/n ;
dt = t/10 ;
k =1;
X_f = zeros(5,1);
theta1 = 0;
theta2 = 0;
X_f = eye(3);%[cos(X_f(3)) sin(X_f(3)) X_f(1) ; -sin(X_f(3)) cos(X_f(3)) X_f(2) ; 0 0 1];
for j = 1:n
    %j
    [X_f,theta1,theta2] = flow_exp(X_f,t,b,0,Final_A(:,1),W,dt,theta1,theta2);
    a1 = X_f;
    %theta1 = b*t;
    %theta2 = 0;
    for i = 1:n
        i,j
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,2),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,2),W,dt,theta1,theta2);
    end
    %X_f = X_f^n;
    %a2 = X_f;
    %X_f = eye(3);
    [X_f,theta1,theta2] = flow_exp(X_f,t,b,0,-Final_A(:,1),W,dt,theta1,theta2);
    %theta1 = 0;
    %theta2 = 0;
    %a3 = X_f;
    %X_f = eye(3);
    for i =1:n
        i,j
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,2),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,2),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,1),W,dt,theta1,theta2);
    end
    %X_f = X_f^n;
    %a4 = X_f;
end
%theta1 = 0 ;
%theta2 = 0 ;
%a5 = (a4*a3*a2*a1)^n;
%X_f = eye(3);
for j = 1:n
    [X_f,theta1,theta2] = flow_exp(X_f,t,c,0,Final_A(:,2),W,dt,theta1,theta2);
    %j
    %theta2 = c*t;
    %a6 = X_f;
    %X_f = eye(3);
    for i = 1:n
        i,j
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,2),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,2),W,dt,theta1,theta2);
    end
    %X_f = X_f^n;
    %a7 = X_f;
    %X_f = eye(3);
    [X_f,theta1,theta2] = flow_exp(X_f,t,c,0,-Final_A(:,2),W,dt,theta1,theta2);
    %a8 = X_f;
    %X_f = eye(3);
    for i = 1:n
        i,j
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,2),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,1),W,dt,theta1,theta2);
        [X_f,theta1,theta2] = flow_exp(X_f,t,1,0,-Final_A(:,2),W,dt,theta1,theta2);
    end
    %X_f = X_f^n;
    %a9 = X_f;    
end
%a10 = (a9*a8*a7*a6)^n;
%a11 = a10*a5




