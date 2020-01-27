epsilon = 4.4;  % Relative dielectric constant
R = 5.01;       % Ångströms
l = 0:3;        % Angular momentum
delta = zeros(1, length(l));
alpha = 0.529;  % Conversion factor Å <-> a_0
beta = 27.211;  % Conversion factor Hartree <-> eV
V_0 = 0.75; % Potential < R [eV]
r = linspace(0, 30, 1e5);

for i = 1:length(delta)
    Consts = [V_0/beta epsilon R/alpha 0 l(i)];
    delta(i) = bisection_search(@V_Dielectric, Consts, -V_0/beta, [R R + 1]/alpha, 1e-5)*alpha - R;
end

fig = figure;
hold on
for i = 1:length(l)
    Consts = [V_0/beta epsilon R/alpha delta(i)/alpha l(i)];
    plot(r, beta*V_Dielectric(r/alpha, Consts));
    
    Consts = [V_0/beta R/alpha l(1)];
    plot(r, beta*V_Coulombic(r/alpha, Consts));
end

xlabel('r [Å]')
ylabel('V(r) [eV]')
set(gca, 'FontSize', 14)
axis([0 30 (-V_0 - 0.5) 3.0])