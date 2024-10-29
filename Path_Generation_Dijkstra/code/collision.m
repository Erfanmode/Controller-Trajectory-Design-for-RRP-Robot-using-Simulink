function collide=collision(index,i_,j_,obs,points)
% collision either happens when we pass cross through
% a line or when we pass through a close pointstacle
collide=0;
tol=1e-12;
ii=index(1); jj=index(2);
p1=points{ii}(jj,1:2);
v1=points{i_}(j_,1:2)-points{ii}(jj,1:2);
for i=1:size(points,2)-1
    for j=1:size(points{i},1)
        if j==size(points{i},1)
            if size(obs{i},1)==size(points{i},1)
                k=j;
            else
                k=1;
            end
        else
            k=j+1;
        end
        if isequal([ii,jj,i_,j_],[i,j,i,k]) || isequal([ii,jj,i_,j_],[i,k,i,j])
            continue
        end
        p2=points{i}(j,1:2);
        v2=points{i}(k,1:2)-points{i}(j,1:2);
        A=[v1',v2']; B=(p2-p1)';
        if abs(det(A))>tol
            temp=A\B;
            alpha=temp(1); beta=-temp(2);
            if alpha>tol && alpha<1-tol && beta>-tol && beta<1+tol
                collide=1;
                break
            end
        end
        
        if ii==size(points,2),continue,end
        if size(obs{ii},1)~=size(points{ii},1)
            if jj==1
                s1=-points{ii}(jj,1:2)+points{ii}(end,1:2);
                s2=points{ii}(jj+1,1:2)-points{ii}(jj,1:2);
            elseif jj==size(points{ii},1)
                s1=-points{ii}(jj,1:2)+points{ii}(jj-1,1:2);
                s2=points{ii}(1,1:2)-points{ii}(jj,1:2);
            else
                s1=-points{ii}(jj,1:2)+points{ii}(jj-1,1:2);
                s2=points{ii}(jj+1,1:2)-points{ii}(jj,1:2);
            end
        elseif jj==1 || jj==size(points{ii},1)
            continue
        else
            s1=-points{ii}(jj,1:2)+points{ii}(jj-1,1:2);
            s2=points{ii}(jj+1,1:2)-points{ii}(jj,1:2);
        end
         ii0=points{ii}(jj,5); jj0=points{ii}(jj,6);
         v0=points{ii0}(jj0,1:2)-points{ii}(jj,1:2);
         tv1=wrapTo2Pi(atan2(v1(2),v1(1))-atan2(s1(2),s1(1)));  
         ts2=wrapTo2Pi(atan2(s2(2),s2(1))-atan2(s1(2),s1(1)));  
         tv0=wrapTo2Pi(atan2(v0(2),v0(1))-atan2(s1(2),s1(1))+tol); 
         
         if (tv1<ts2 && tv0>ts2) || (tv1>ts2 && tv0<ts2)
            collide=1;
         end
        
    end
    if collide
        break
    end
end

end