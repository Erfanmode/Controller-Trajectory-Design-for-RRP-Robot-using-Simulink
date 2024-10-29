function  P = Path_generator_1 (Xs, Xf, eta, alpha, B)
P=[];
position=Xs;
r0=2;
k=0;
epsilon=0.1;
N=5000; % to set a maximum for iteration even though we don't reach the final point
while norm(position-Xf)>0.1 
    k=k+1;
    if k>N
        warning('running time error');
        break
    end
    F_repulsion=[0,0];
    for i=1:length(B)
        for j=1:length(B{i})
            p1=B{i}(j,:);
            if j~=length(B{i})
                p2=B{i}(j+1,:);
            else
                p2=B{i}(1,:);
            end
            D=[(p2-p1)', -[0,-1;1,0]*(p2-p1)'];
            if det(D)~=0
                ab=D\(position-p1)';
            end
            if ab(1)<0
                H=p1;
            elseif ab(1)>1
                H=p2;
            else
                H=ab(1)*(p2-p1)+p1;
            end
            r=norm(position-H);
            if r<r0
                F_repulsion = alpha/r^3*(1/r - 1/r0)*(position-H) + F_repulsion;
            end
        end
    end
    F_attraction= -eta*(position-Xf);
    n=10;
    position = position + epsilon*(F_attraction+F_repulsion)/norm((F_attraction+F_repulsion));
    P(k,:)=position;
    
    
end

end