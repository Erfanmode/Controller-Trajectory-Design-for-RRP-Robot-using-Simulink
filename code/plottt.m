function plottt(out)
t=out.simout.Time;
theta1=out.simout.Data*180/pi;
theta2=out.simout1.Data*180/pi;
d=out.simout2.Data*100;
del_xyz=(out.simout4.Data-out.simout3.Data)*100;

plot(t,theta1);
xlabel("time_{(S)}");
ylabel("\Theta_1_{(deg)}");
title("\Theta_1_{(time)}");
figure

plot(t,theta2);
xlabel("time_{(S)}");
ylabel("\Theta_2_{(deg)}");
title("\Theta_2_{(time)}");
figure

plot(t,d);
xlabel("time_{(S)}");
ylabel("d_{(cm)}");
title("d_{(time)}");
figure

plot(t,del_xyz);
legend({"X error","Y error","Z error"});
title("Difference between trajetory & end-effector");
xlabel("time_{(S)}");
ylabel("difference_{(cm)}");
end