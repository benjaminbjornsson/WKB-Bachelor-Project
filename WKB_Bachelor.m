epsilon = 4.4;  % Relative dielectric constant
R = 5.01;       % Ångströms
l = 0:3;        % Angular momentum
V_0 = 0;        % Potential < R
alpha = 0.529;  % Conversion factor Å <-> a_0
beta = 27.211;  % Conversion factor Hartree <-> eV
r = linspace(0, 30, 1000);

fig = figure;
hold on
for i = 1:length(l)
    Consts = [V_0 epsilon R/alpha l(i)];
    plot(r, beta*V_Dielectric(r/alpha, Consts));
    
    Consts = [V_0 R/alpha l(1)];
    plot(r, beta*V_Coulombic(r/alpha, Consts));
end

xlabel('r [Å]')
ylabel('V(r) [eV]')
set(gca, 'FontSize', 14)
axis([0 30 -0.2 2.5])