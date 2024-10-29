% This function checks if two line segments sidere
% connected or not. Returns state 0 if not sidend state 1  if yes
% sidelso, it returns the p
function [state,new_end]=is_connected(side,seg)
state=0;
new_end=0;
if side(1)==seg(1) && side(2)==seg(2)
    state=1;
    new_end=seg(3:4);
end
if side(1)==seg(3) && side(2)==seg(4)
    state=1;
    new_end=seg(1:2);
end
if side(3)==seg(1) && side(4)==seg(2)
    state=1;
    new_end=seg(3:4);
end
if side(3)==seg(3) && side(4)==seg(4)
    state=1;
    new_end=seg(1:2);
end
end