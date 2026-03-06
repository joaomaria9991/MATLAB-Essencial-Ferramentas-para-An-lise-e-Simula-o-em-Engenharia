%% Farmacocinética — gerar plots para slides

clear;
close all;
clc;

%% Parâmetros base
C0 = 10;          % mg/L
k  = 0.4;         % 1/h
tspan = [0 24];   % horas

% Para curvas mais suaves no plot (apenas para visualização)
t_plot = tspan(1):0.001:tspan(2);

%% Solver settings
opts = odeset('RelTol',1e-6,'AbsTol',1e-9);

%% ============================
% FIGURA 1 — ode45 vs analítica
% ============================
odefun = @(t,C) -k*C;

[t,C] = ode45(odefun, tspan, C0, opts);
C_ana = C0 * exp(-k*t_plot);

fig1 = figure('Color','w','Position',[100 100 900 550]);
plot(t, C, 'LineWidth', 2); hold on
plot(t_plot, C_ana, '--', 'LineWidth', 2); hold off

title('Farmacocinética — Modelo Monocompartimental (IV)')
xlabel('Tempo (h)')
ylabel('Concentração C(t) (mg/L)')
legend('ode45 (numérico)','Solução analítica','Location','northeast')
grid on


%% ============================
% FIGURA 2 — efeito de k
% ============================
k_list = [0.2 0.4 0.8];  % 1/h

fig2 = figure('Color','w','Position',[100 100 900 550]);
hold on
for kk = k_list
    [t2,C2] = ode45(@(t,C) -kk*C, tspan, C0, opts);
    plot(t2, C2, 'LineWidth', 2);
end
hold off

title('Efeito de k na eliminação')
xlabel('Tempo (h)')
ylabel('Concentração C(t) (mg/L)')
legend("k=0.2","k=0.4","k=0.8",'Location','northeast')
grid on

