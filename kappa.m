function kappa = kappa(r, V, Consts, E)
%KAPPA Summary of this function goes here
%   Detailed explanation goes here
    kappa = sqrt(2*(V(r, Consts) - E));
%     kappa = (V(r, Consts) - E);
end

