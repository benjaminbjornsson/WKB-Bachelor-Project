function V = V_Coulombic(r, Consts)
%V_COULOMBIC Summary of this function goes here
%   Detailed explanation goes here
    V_0 = Consts(1);
    R = Consts(2);
    l = Consts(3);
    
    V = 1./r + (l*(l + 1))./(2*r.^2);
end

