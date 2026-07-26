function [V, delta, iteration] = newton_raphson(Ybus, V, delta)

%----------------------------------------
% Newton-Raphson Load Flow Solver
%----------------------------------------

tolerance = 1e-6;
maxIter = 20;
iteration = 0;

while iteration < maxIter

    %----------------------------------------
    % Calculate Bus Powers
    %----------------------------------------
    [P, Q] = power_calculation(Ybus, V, delta);

    %----------------------------------------
    % Specified Power
    %----------------------------------------
    P_spec = [
        -0.90
        -1.00
        ];

    Q_spec = [
        -0.30
        -0.35
        ];

    %----------------------------------------
    % Power Mismatch
    %----------------------------------------
    dP = P_spec - P(2:3);
    dQ = Q_spec - Q(2:3);

    mismatch = [
        dP
        dQ
        ];

    %----------------------------------------
    % Check Convergence
    %----------------------------------------
    if max(abs(mismatch)) < tolerance
        break;
    end

    %----------------------------------------
    % Jacobian Matrix
    %----------------------------------------
    J = jacobian(Ybus, V, delta, P, Q);

    %----------------------------------------
    % Solve for Corrections
    %----------------------------------------
    dx = J \ mismatch;
    fprintf('Iteration %2d : Max Mismatch = %.8f\n', ...
        iteration + 1, max(abs(mismatch)));
    
    %----------------------------------------
    % Update Angles
    %----------------------------------------
    delta(2:3) = delta(2:3) + dx(1:2);

    %----------------------------------------
    % Update Voltages
    %----------------------------------------
    V(2:3) = V(2:3) + dx(3:4);

    iteration = iteration + 1;

    fprintf('Iteration %d Completed\n\n', iteration);

end

% This must be INSIDE the function
if iteration < maxIter
    fprintf('=======================================\n');
    fprintf('Newton-Raphson Converged Successfully\n');
    fprintf('Total Iterations : %d\n', iteration);
    fprintf('=======================================\n');
else
    warning('Maximum iterations reached. Solution did not converge.');
end

end
    