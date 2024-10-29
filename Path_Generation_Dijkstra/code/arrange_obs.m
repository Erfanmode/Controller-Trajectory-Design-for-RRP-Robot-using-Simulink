function obs=arrange_obs(obs_arr)
%%% Now we rearrange and find each close loop obstacles
k=0; % Number of obstacle groups
obs={}; % Each cell array is all points for on obstacles
while ~isempty(obs_arr)
    k=k+1; % We go after the next obstacle
    side=obs_arr(1,:);
    obs_arr(1,:)=[];
    obs{k}=[side(1:2);side(3:4)];
    signal=1;
    while signal
        signal=0;
        i=1;
        while i<=size(obs_arr,1)
            seg=obs_arr(i,:);
            [state,new_end]=is_connected(side,seg);
            if state
                obs{k}(end+1,:)=new_end;
                side=seg;
                obs_arr(i,:)=[];
                signal=1; % if signal is 1, it means we at least find one
                % connected line segement
            end
            i=i+1;
        end
    end
    if obs{k}(1,1)~=obs{k}(end,1) || obs{k}(1,2)~=obs{k}(end,2)
        temp=obs{k}(1,:); obs{k}(1,:)=obs{k}(2,:);
        obs{k}(2,:)=temp;
    end
end
end