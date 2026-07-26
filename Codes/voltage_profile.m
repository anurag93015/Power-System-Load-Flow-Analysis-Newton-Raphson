function voltage_profile(V)

%----------------------------------------
% Voltage Profile Plot
%----------------------------------------

bus = 1:length(V)
%% 

figure;

plot(bus, V, '-o','LineWidth', 2, 'MarkerSize', 8 );

grid on;

xlabel('Bus Number');
ylabel('Voltage Magnitude (p.u.)');
title('Voltage Profile');

xticks(bus);

ylim([0.9 1.1]);

end


