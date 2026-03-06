%% Crescimento bacteriano - modelo logístico
clear;
close all;
clc;

%% Parâmetros
N0 = 1e6;        % população inicial
r  = 0.8;        % taxa de crescimento (1/h)
K  = 1e9;        % capacidade máxima do meio
tspan = [0 24];  % tempo em horas

%% Resolver a ODE
odefun = @(t,N) r*N*(1 - N/K);

opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
[t,N] = ode45(odefun, tspan, N0, opts);

%% Plot principal
figure('Color','w');
plot(t, N, 'LineWidth', 2)
title('Crescimento Bacteriano - Modelo Logístico')
xlabel('Tempo (h)')
ylabel('População bacteriana N(t)')
grid on

%% Comparação com diferentes taxas de crescimento
r_list = [0.4 0.8 1.2];

figure('Color','w');
hold on
for rr = r_list
    [t2,N2] = ode45(@(t,N) rr*N*(1 - N/K), tspan, N0, opts);
    plot(t2, N2, 'LineWidth', 2)
end
hold off

title('Impacto da taxa de crescimento r')
xlabel('Tempo (h)')
ylabel('População bacteriana N(t)')
legend('r = 0.4','r = 0.8','r = 1.2','Location','southeast')
grid on