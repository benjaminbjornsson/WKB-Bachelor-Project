gamma = 1e-7;   % Bisection error
epsilon = 4.4;  % Relative dielectric constant
l = 0:2;        % Angular momentum
delta = zeros(1, length(l));
alpha = 0.529;  % Conversion factor Å <-> a_0
beta = 27.211;  % Conversion factor Hartree <-> eV
V_0 = 10.0;      % Potential < R [eV]
r = linspace(0, 75, 1e7);
N = 60;

R_0 = 3.55;     % C60 inner sphere radius [Ångström]
DeltaR = 1.46;  % C60 shell thickness [Ångström]

R = @(N) sqrt(N)/sqrt(60)*R_0 + DeltaR;

E_A_2 = @(N) 2.8521 - 15.7922./R(N);

Consts = [V_0/beta epsilon R(N)/alpha 0 l(1)];
[PKS, LOCS] = findpeaks(beta*V_Dielectric(r/alpha, Consts));

for i = 1:length(delta)
    Consts = [V_0/beta epsilon R(N)/alpha 0 l(i)];
	delta(i) = bisection_search(@V_Dielectric, Consts, -V_0/beta, [R(N) r(LOCS)]/alpha, gamma, false, false)*alpha - R(N);
end

for i = 1:length(l)
    hold on
    Consts = [V_0/beta epsilon R(N)/alpha delta(i)/alpha l(i)];
    plot(r, beta*V_Dielectric(r/alpha, Consts));
end

for i = 1:length(l)
    Consts = [V_0/beta epsilon R(N)/alpha delta(i) l(i)];
    r_L(i) = bisection_search(@V_Dielectric, Consts, -E_A_2(N)/beta, [(R(N) + delta(i)) (R(N) + 1)]/alpha, gamma, false, true)*alpha;
    r_R(i) = bisection_search(@V_Dielectric, Consts, -E_A_2(N)/beta, [r(LOCS) r(end)]/alpha, gamma, true, true)*alpha;
end

yline(-E_A_2(N));
plot(r_L, -E_A_2(N)*ones(1,3), '*')
plot(r_R, -E_A_2(N)*ones(1,3), '*')

muc2 = 1;
hbarc = 1;

for i = 1:length(l)
    Consts = [V_0 epsilon R(N)/alpha 0 l(i)];
    r = linspace(r_L(i), r_R(i), 1e7);
    plot(r, sqrt(beta)*kappa(r/alpha, @V_Dielectric, Consts, -E_A_2(N)/beta));
end

i = 1;
fun = @(r) kappa(r/alpha, @V_Dielectric, Consts, -E_A_2(N)/beta);
f = exp(integral(fun, r_L(i), r_R(i)));
Tr = 4/(2*f + 1/(2*f))^2;
vinc = sqrt(2*(-E_A_2(N))/beta);
(2*r_L(i))/(Tr*vinc)