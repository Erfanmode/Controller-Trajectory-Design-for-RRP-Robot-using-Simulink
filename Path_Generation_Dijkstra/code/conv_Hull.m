function [conv_obs,points]=conv_Hull(obs,rob)
tol=1e-6;
points={};
conv_obs={};
for i=1:size(obs,2)
    if isequal(obs{i}(1,1:2),obs{i}(end,1:2))
        k=size(obs{i},1)-1;
    else
        k=size(obs{i},1);
    end
    z=0;
    for j=1:k
        for m=1:size(rob,1)
            z=z+1;
            points{i}(z,:)=rob(1,:)-rob(m,:) + obs{i}(j,:);
        end
    end
end
% Now we have the points, we find the convex around each obstacle
for i=1:size(points,2)
    % First, find the furthest left point
    max_x=-inf;
    max_j=1;
    for j=1:size(points{i},1)
        if points{i}(j,1)>max_x
            max_j=j;
            max_x=points{i}(j,1);
        end
    end
    conv_obs{i}(1,:)=points{i}(max_j,:);
    k=1; % counter for 'conv_obs{i}'
    while norm(conv_obs{i}(1,:) - conv_obs{i}(k,:))>tol || k==1
        min_angle=2*pi+tol;
        if k==1
            vector1=[1,0];
        else
            vector1=conv_obs{i}(k-1,:) - conv_obs{i}(k,:);
        end
        for j=1:size(points{i},1)
            vector2=points{i}(j,:) - conv_obs{i}(k,:);
            angle=wrapTo2Pi(atan2(vector2(2),vector2(1))-atan2(vector1(2),vector1(1)));
            if angle<tol || angle>2*pi-tol || norm(vector2)<tol || norm(vector2-vector1)<tol
                continue
            end
            if angle<min_angle
                min_angle=angle;
                conv_obs{i}(k+1,:)=points{i}(j,:);
            end
        end
        k=k+1;
    end
end

end