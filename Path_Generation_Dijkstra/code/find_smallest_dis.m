function index=find_smallest_dis(points)
dis_min=1e6;
index=[];
for i=1:size(points,2)
    for j=1:size(points{i},1)
        if ~points{i}(j,4)
            dis=points{i}(j,3);
            if dis<dis_min
                dis_min=dis;
                index=[i,j];
            end 
        end
    end
end
end