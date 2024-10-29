clear
clc
close all
%% Part 1
%%% First we determine obstacles and robot dimension
file=readlines('input.txt');
r_N=find(file=='N'); % row number for 'N'
r_m=find(file=='m'); % row number for 'm'
obs_arr=[]; %obstacle array
rob_arr=[]; %robot array
start_end=[]; %start and end point for robot path
for i=r_N:r_m
    num=str2num(file(i,:));
    if ~isempty(num)
        if length(num)==4
            obs_arr=cat(1,obs_arr,num);
        else
            start_end(end+1,:)=str2num(file(i,:));
        end
    end
end

for i=r_m:size(file,1)
    num=str2num(file(i,:));
    if ~isempty(num)
        rob_arr=cat(1,rob_arr,num);
    end
end

obs=arrange_obs(obs_arr);
for i=1:length(obs)
        plot(obs{i}(:,1),obs{i}(:,2));
        hold on
end
scatter(start_end(:,1),start_end(:,2));

% Now we utilize 'Road Mapping' algoritm
path=find_path(obs,start_end);

hold on
plot(path(:,1),path(:,2));
xlim([0,30]);
ylim([-5,25]);
%% Part 2
[conv_obs,conv_points]=conv_Hull(obs,rob_arr);
% Now we utilize 'Road Mapping' algoritm
figure
for i=1:length(conv_obs)
        plot(conv_obs{i}(:,1),conv_obs{i}(:,2));
        hold on
        scatter(conv_points{i}(:,1),conv_points{i}(:,2));
        hold on
end
scatter(start_end(:,1),start_end(:,2));

% Now we utilize 'Road Mapping' algoritm
path=find_path(conv_obs,start_end);

hold on
plot(path(:,1),path(:,2));
xlim([0,25]);
ylim([0,25]);

hold on
rob=[rob_arr;rob_arr(1,:)];
plot(rob(:,1),rob(:,2));



