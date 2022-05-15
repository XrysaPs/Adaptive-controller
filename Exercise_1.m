clear;
clc;
close all;

%% a)
tspan = [0 120];
x0=[0; 0; 0];
Ap=[-0.8060 1; -9.1486 -4.59];
Bp=[-0.04; -4.59];
Cp=[1; 0];
C=[0 Cp'];
A=[0 Cp'; zeros(2,1) Ap];
B=[0; Bp];
Br=[-1; 0; 0];

Q=[50 0 0; 0 0 0; 0 0 0];
R=1;
[K,S,e] = lqr(A,B,Q,R);

Am=A-B*K;

[t_ref,x_ref]=ode45(@(t,x_ref)dxfunction(t,x_ref,Am,Br), tspan, x0);
y_ref=C*x_ref';
figure(1);
plot(t_ref,y_ref, 'Linewidth', 1.5);

hold on;
[t,x_real]=ode45(@(t,x_real)dxreal(t,x_real,A,B,K,Br), tspan, x0);
y_real=C*x_real';
plot(t,y_real,'--', 'Linewidth', 1.5);

%% plot r
hold on;
i=1;
for t1=0:0.1:tspan(2)
if t1>=0 && t1<1
    r(i)=0;
elseif t1>=1 && t1<10
    r(i)=0.5;
elseif t1>=10 && t1<22
    r(i)=0;
elseif t1>=22 && t1<32
    r(i)=-0.5;
elseif t1>=32 && t1<45
    r(i)=0;
elseif t1>=45 && t1<55
    r(i)=1;
elseif t1>=55 && t1<65
    r(i)=0;
elseif t1>=65 && t1<75
    r(i)=-1;
elseif t1>=75 && t1<85
    r(i)=0;
elseif t1>=85 && t1<95
    r(i)=0.5;
elseif t1>=95
    r(i)=0;
end
i=i+1;
end

plot((0:0.1:tspan(2)), r, 'Linewidth', 1);
ylabel('a in rad');
xlabel('Time t in sec');
legend('a_{ref}', 'a_{real}','r');
title('a');

%% error
figure(2);
plot(t, x_real(:,1), 'Linewidth', 1.5);
ylabel('error in rad');
xlabel('Time t in sec');
legend('Error');
title('Error');

%% b)
x0=[0; 0; 0];
D=2;
ka=-5;
kq=5;
f=@(a,q)ka*a+kq*q;
[t,x]=ode45(@(t,x)dxWithUncertainty(t,x,A,B,f,D,K,Br), tspan, x0);
figure(3);
plot(t,x(:,2));
ylabel('a in rad');
xlabel('Time t in sec');
legend('a');
title('a');

%% c)
array=[2; -5; 5];
x0=[0; 0; 0];
theta0=[0;0;0];
xm0=[0; 0; 0;];
%gama=eye(3);
gama = [-10 0 0; 0 -2 0; 0 0 -1];
Q=eye(3);
P=lyap(Am',Q);
[t,z]=ode45(@(t,z)dxWithUncertaintyAdaptive(t,z,Am,B,Br,K',P,gama,array), tspan, [x0; theta0; xm0]);

figure(4);
plot(t,z(:,2), 'Linewidth', 1);

hold on;
i=1;
for t2=0:0.1:tspan(2)
if t2>=0 && t2<1
    r(i)=0;
elseif t2>=1 && t2<10
    r(i)=0.5;
elseif t2>=10 && t2<22
    r(i)=0;
elseif t2>=22 && t2<32
    r(i)=-0.5;
elseif t2>=32 && t2<45
    r(i)=0;
elseif t2>=45 && t2<55
    r(i)=1;
elseif t2>=55 && t2<65
    r(i)=0;
elseif t2>=65 && t2<75
    r(i)=-1;
elseif t2>=75 && t2<85
    r(i)=0;
elseif t2>=85 && t2<95
    r(i)=0.5;
elseif t2>=95
    r(i)=0;
end
i=i+1;
end

plot((0:0.1:tspan(2)), r, 'Linewidth', 1);
plot(t_ref,y_ref, 'Linewidth', 1);

ylabel('a in rad');
xlabel('Time t in sec');
legend('a_{real}', 'r', 'a_{ref}');
title('a');





