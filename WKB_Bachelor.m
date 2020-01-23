epsilon = 4.4;  % Relative dielectric constant
R = 5.01;       % Ångströms
l = 0:3;
V_0 = 0;

r = linspace(0, 30, 1000);

figure
hold on
for i = 1:length(l)
    Consts = [V_0 epsilon R l(i) delta];
    plot(r, V_Dielectric(r, Consts));
end
    
Consts = [V_0 R l(1)];
plot(r, 14.4*V_Coulombic(r, Consts));

axis([0 30 -0.2 1.5])