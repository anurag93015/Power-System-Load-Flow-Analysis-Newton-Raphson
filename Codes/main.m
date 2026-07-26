clc;
clear;
close all;

disp('=======================================');
disp(' POWER SYSTEM LOAD FLOW ANALYSIS');
disp('=======================================');

%% ------------------------------------------
% Transmission Line Data
%-------------------------------------------
lineData = line_data();

disp('Transmission Line Data');
disp(lineData);

%% ------------------------------------------
% Create Y-Bus Matrix
%-------------------------------------------
Ybus = create_ybus(lineData);

disp('Y-Bus Matrix');
disp(Ybus);

%% ------------------------------------------
% Initial Voltage Magnitudes (p.u.)
%-------------------------------------------
V = [
    1.05
    1.00
    1.00
];

%% ------------------------------------------
% Initial Voltage Angles (Radians)
%-------------------------------------------
delta = [
    0
    0
    0
];

%% ------------------------------------------
% Newton-Raphson Load Flow
%-------------------------------------------
[V, delta, iteration] = newton_raphson(Ybus, V, delta);

%% ------------------------------------------
% Final Results
%-------------------------------------------
disp(' ');
disp('=======================================');
disp(' FINAL LOAD FLOW RESULTS');
disp('=======================================');

fprintf('\nBus\tVoltage (pu)\tAngle (deg)\n');
fprintf('---------------------------------------------\n');

for i = 1:length(V)
    fprintf('%d\t%.4f\t\t%.4f\n', ...
        i, V(i), rad2deg(delta(i)));
end

fprintf('\nTotal Iterations : %d\n', iteration);

%% ------------------------------------------
% Voltage Profile
%-------------------------------------------

voltage_profile(V);

%----------------------------------------
% Line Power Flow 
%----------------------------------------

line_flow(lineData, V, delta);

%----------------------------------------
% Save Load Flow Results
%----------------------------------------

save_results(V, delta);

saveas(gcf,'../Images/voltage_profile.png')