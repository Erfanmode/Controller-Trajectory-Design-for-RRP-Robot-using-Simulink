function arr=Uniq(A) % this function remove repeated points
arr=[];
for i=1:size(A,1)
    signal=0; % To detect if any row is repeated
    for j=i+1:size(A,1)
        is_same=1;
        for k=1:size(A,2)
            is_same=is_same*(A(i,k)==A(j,k));
        end
        if is_same
           signal=1;
           break
        end
    end
    if ~signal
        arr(end+1,:)=A(i,:);
    end
end
end