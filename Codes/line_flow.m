function line_flow(lineData, V, delta)

%----------------------------------------
% Line Power Flow and Loss Calculation
%----------------------------------------

numLines = size(lineData,1);

disp(' ')
disp('==============================================')
disp('        LINE POWER FLOW RESULTS')
disp('==============================================')

totalPloss = 0;
totalQloss = 0;

fprintf('\n');
fprintf('-------------------------------------------------------------------------------\n');
fprintf('From   To      Pij        Qij        Pji        Qji      Ploss      Qloss\n');
fprintf('-------------------------------------------------------------------------------\n');

for k = 1:numLines

    %----------------------------
    % Read Line Data
    %----------------------------

    from = lineData(k,1);
    to   = lineData(k,2);

    R = lineData(k,3);
    X = lineData(k,4);

    %----------------------------
    % Line Impedance & Admittance
    %----------------------------

    Z = R + 1i*X;
    Y = 1/Z;

    %----------------------------
    % Complex Bus Voltages
    %----------------------------

    Vi = V(from) * exp(1i*delta(from));
    Vj = V(to)   * exp(1i*delta(to));

    %----------------------------
    % Forward Current (i → j)
    %----------------------------

    Iij = Y * (Vi - Vj);

    %----------------------------
    % Forward Complex Power
    %----------------------------

    Sij = Vi * conj(Iij);

    Pij = real(Sij);
    Qij = imag(Sij);

    %----------------------------
    % Reverse Current (j → i)
    %----------------------------

    Iji = Y * (Vj - Vi);

    %----------------------------
    % Reverse Complex Power
    %----------------------------

    Sji = Vj * conj(Iji);

    Pji = real(Sji);
    Qji = imag(Sji);

    %----------------------------
    % Line Loss
    %----------------------------

    Ploss = Pij + Pji;
    Qloss = Qij + Qji;

    %----------------------------
    % Total Loss
    %----------------------------

    totalPloss = totalPloss + Ploss;
    totalQloss = totalQloss + Qloss;

    %----------------------------
    % Display Results
    %----------------------------

    fprintf('%3d %5d %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f\n', ...
        from, to, Pij, Qij, Pji, Qji, Ploss, Qloss);

end

fprintf('-------------------------------------------------------------------------------\n');

fprintf('\nTotal Active Power Loss   = %.6f pu\n', totalPloss);
fprintf('Total Reactive Power Loss = %.6f pu\n', totalQloss);

fprintf('==============================================\n');

end