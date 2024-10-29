function path=find_path(obs,start_end)
points=obs; 
points{end+1}=start_end; % points are all the points including obstacle and
                         % starting and finishing point 
% Now add the minimum distance to them (the 3rd column in each cell)
% Also add a signal to each point (the 4th column in each cell) which
% determines whether the point is visited (1) or not (0)
% Furthermore we record the points which should be connected to 
% make minimum distance to distination.(5th column=i,6th column=j)
points_num=0; % total number of points
for i=1:size(points,2)
     points{i}=Uniq(points{i}); % To remove repeated points
     points{i}(:,end+1)=1e6;
     points{i}(:,end+1)=0;
     points{i}(:,end+1)=0;
     points{i}(:,end+1)=0;
     points_num=points_num+size(points{i},1);
end
points{end}(2,3)=0; % sets distance of end point to zero
% Now we update distances
visp=[size(points,2),2]; % determines indices of visiting point
visp_pre=[];
visit=0;
while visit<points_num 
    if visit, visp=find_smallest_dis(points);end
    if isempty(visp), visit=visit+1; continue, end
    points{visp(1)}(visp(2),4)=1; % sets visited state to one
    visp_tmp=[];
    dis_min=1e6; % minimum differential distance between current and next point
    for i=1:size(points,2)
        for j=1:size(points{i},1)
            if ~points{i}(j,4)
                if ~collision(visp,i,j,obs,points)
                    % distance from end point
                    diff_dis=norm(points{visp(1)}(visp(2),1:2)-points{i}(j,1:2));
                    end_dis=points{visp(1)}(visp(2),3)+diff_dis;
                    if end_dis < points{i}(j,3)
                        points{i}(j,3)=end_dis;
                        % Identifies which points is next in path
                        % to the destination
                        points{i}(j,5:6)=visp;
                    end
                    if points{i}(j,3)<dis_min
                        dis_min=points{i}(j,3);
                        visp_tmp=[i,j];
                    end
                end
            end
        end
    end
    visit=visit+1;
    visp=visp_tmp;
end

path=start_end(1,:);
idx=[size(points,2),1];
while norm(path(end,:)-start_end(2,:))>1e-12
    idx=points{idx(1)}(idx(2),5:6);
    path(end+1,:)=points{idx(1)}(idx(2),1:2);
end
end