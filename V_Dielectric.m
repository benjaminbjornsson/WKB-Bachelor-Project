function V = V_Dielectric(r,Consts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    V_0 = Consts(1);
    epsilon = Consts(2);
    R = Consts(3);
    l = Consts(4);

    if r <= R
        V = -V_0;
    else
        V = -1/2*(epsilon - 1)/(epsilon + 2)*(R/r^2 + 1/(2*(R - r)) + 1/(2*(R + r))) + 1/r + (l*(l + 1))/(2*r^2);
    end
end

