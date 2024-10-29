Ra=50;
Jm=0.1;
Jg=0.05;
r=50;
Bm=0.01;
Km=7.5; Kb=Km;
J=Jg+Jm;
B=Bm+Km*Kb/Ra;
radius=0.010 ; % in meters
max_v=1e6; %volt
%% Problem 2
% Firstly, run  the simulation of "model_1"
plott(out);
%% Problem 3
% Firstly, run  the code of this section
s=tf('s');
G1=(Km/Ra)/(s*(J*s+B))/r;
G2=(Km/Ra)/(s*(J*s+B))*radius;
% Kd1=C1.Kd; Ki1=C1.Ki; Kp1=C1.Kp;
% Kd2=C2.Kd; Ki2=C2.Ki; Kp2=C2.Kp;
Kd1=145; Ki1=10; Kp1=1963;
Kd2=97; Ki2=10; Kp2=2377;
th1_d=50*pi/180;
th2_d=35*pi/180;
d_d=15/100;
%%
% run the simulation of "model_2" and then run the code in this section
plott(out);
%% Problem 4
% First run this
Kd1=145; Ki1=10; Kp1=1963;
Kd2=97; Ki2=10; Kp2=2377;
L1=310; %mm
L2=300; %mm
position=[284.829 -164.446 190.293 ;
          91.203 340.373 605.682 ];
parameters=zeros(3,2);
a=zeros(3,4);
s=1; % in seconds
for k=1:2
    x=position(k,1);
    y=position(k,2);
    z=position(k,3);
    t1=atan2(y,x);
    if abs(x)<1e-3
       t2=atan( (z-L1)*sin(t1)/y );
       d=y/(sin(t1)*cos(t2))-L2; 
    else
       t2=atan( (z-L1)*cos(t1)/x );
       d=x/(cos(t1)*cos(t2))-L2;
    end
    parameters(:,k)=[t1;t2;d];
end

%Now we calculate trajectory coefficient
a(:,1)=parameters(:,1);
%a(:,2) remain zero
a(:,4)=(-parameters(:,2)+a(:,1))/(0.5*s^3);
a(:,3)= -1.5*a(:,4)*s;
%Now we generate trajactory inputs
t=0:0.01:1;
f=@(x) a(:,1)+a(:,2)*x+a(:,3)*x.^2+a(:,4)*x.^3;
output=f(t); % outputs are in mm and rad
joints_traj=[t',output(1,:)',t',output(2,:)',t',output(3,:)'];
%%
% Then run "model_3" and run the code of this section
plottt(out);
