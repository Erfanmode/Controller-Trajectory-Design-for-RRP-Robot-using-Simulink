function  P = Path_generator_3 (Xs, Xf, eta, alpha, B)
P=[];
a=6;
position=Xs;
r0=2;
k=0;
epsilon=0.1;
N=5000; % to set a maximum for iteration even though we don't reach the final point
signal=false;
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
    %%%
    if signal
        dr_t=Xf-position;
        tar_ang=atan2(dr_t(2),dr_t(1));% This is target's angle
        dif_ang_min=pi;
        distance=norm(dr_t); % We initialize the parameter of 'distance'
        for i=1:length(B)
            ang_1=tar_ang;
            ang_2=tar_ang;
            for j=1:length(B{i})
                dr_B=B{i}(j,:)-position;
                phi=atan2(dr_B(2),dr_B(1));
                if wrapToPi(phi-ang_2)>0
                    ang_2=phi;
                    distance2=norm(dr_B);
                end
                if wrapToPi(phi-ang_1)<0
                    ang_1=phi;
                    distance1=norm(dr_B);
                end
            end
            
            if  distance > distance1 
                dif_ang_min=ang_1-tar_ang;
                delta=-0.01;
                distance=distance1;
            end
            if  distance > distance2 
                dif_ang_min=ang_2-tar_ang;
                distance=distance2;
                delta=0.01;
            end
        end
        position = position + (distance+0.01)*[cos(tar_ang+dif_ang_min+delta),sin(tar_ang+dif_ang_min+delta)];
        k=k-3*n;
        P(k,:)=position;
        signal=false;
    else
        position = position + epsilon*(F_attraction+F_repulsion)/norm((F_attraction+F_repulsion));
        P(k,:)=position;
    end
    %%%
    % We add next part to recognize where path gets stuck
    if k>n 
        if norm( P(k,:)-P(k-randi([1,n]),:) )<1e-6
            signal=true;
        end
    end
end

end