clear
close all
clc
%% Problem 1 & 2
X_start=[1,10];
X_final=[22,12];
etha=1;
alpha=1;
obs1=[6,4;
      9,10;
      12,4;
      6,4];
obs2=[4,12;
      10,18;
      12,16;
      6,10;
      4,12];
obs3=[11,12;
      15,8;
      19,12;
      17,16;
      13,16;
      11,12];

obstacles={obs1,obs2,obs3};

Path_points=Path_generator_1(X_start, X_final, etha, alpha, obstacles);
for i=1:length(obstacles)
        plot(obstacles{i}(:,1),obstacles{i}(:,2));
        hold on
end
plot(Path_points(:,1),Path_points(:,2));
xlim([0,25]);
ylim([0,25]);
%% Problem 3
X_start=[1,10];
X_final=[22,12];
etha=1;
alpha=1;
obs1=[6,4;
      9,10;
      12,4;
      6,4];
obs2=[4,12;
      10,18;
      12,16;
      6,10;
      4,12];
obs3=[11,12;
      15,8;
      19,12;
      17,16;
      13,16;
      11,12];
obs4=[17.5,8;
      17.5,10];
  
obstacles={obs1,obs2,obs3,obs4};
Path_points=Path_generator_1(X_start, X_final, etha, alpha, obstacles);
figure
for i=1:length(obstacles)
        plot(obstacles{i}(:,1),obstacles{i}(:,2));
        hold on
end
plot(Path_points(:,1),Path_points(:,2));
xlim([0,25]);
ylim([0,25]);

%% Problem 4a
X_start=[1,10];
X_final=[22,12];
etha=1;
alpha=1;
obs1=[6,4;
      9,10;
      12,4;
      6,4];
obs2=[4,12;
      10,18;
      12,16;
      6,10;
      4,12];
obs3=[11,12;
      15,8;
      19,12;
      17,16;
      13,16;
      11,12];
obs4=[17.5,8;
      17.5,10];
  
obstacles={obs1,obs2,obs3,obs4};
Path_points=Path_generator_2(X_start, X_final, etha, alpha, obstacles);
figure
for i=1:length(obstacles)
        plot(obstacles{i}(:,1),obstacles{i}(:,2));
        hold on
end
plot(Path_points(:,1),Path_points(:,2));
xlim([0,25]);
ylim([0,25]);

%% Problem 4b

X_start=[1,10];
X_final=[22,12];
etha=1;
alpha=1;
obs1=[6,4;
      9,10;
      12,4;
      6,4];
obs2=[4,12;
      10,18;
      12,16;
      6,10;
      4,12];
obs3=[11,12;
      15,8;
      19,12;
      17,16;
      13,16;
      11,12];
obs4=[17.5,8;
      17.5,10];
  
obstacles={obs1,obs2,obs3,obs4};
Path_points=Path_generator_3(X_start, X_final, etha, alpha, obstacles);
figure
for i=1:length(obstacles)
        plot(obstacles{i}(:,1),obstacles{i}(:,2));
        hold on
end
plot(Path_points(:,1),Path_points(:,2));
xlim([0,25]);
ylim([0,25]);
