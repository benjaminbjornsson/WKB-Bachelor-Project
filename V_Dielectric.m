function V = V_Dielectric(r,Consts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    V_0 = Consts(1);
    epsilon = Consts(2);
    R = Consts(3);
    delta = Consts(4);
    l = Consts(5);
    
    V = -((epsilon - 1)*R^3)./(2*(epsilon + 2)*r.^2.*(r.^2 - R^2)) + 1./r + (l*(l + 1))./(2*r.^2);
    V(r <= (R + delta)) = -V_0;
end

