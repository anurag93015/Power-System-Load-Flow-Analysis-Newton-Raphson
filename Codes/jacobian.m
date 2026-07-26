function J = jacobian(Ybus,V,delta,P,Q)

%----------------------------------------
% Jacobian Matrix for Newton-Raphson
%----------------------------------------

G = real(Ybus);
B = imag(Ybus);

n = length(V);

% Number of non-slack buses
m = n - 1;

%%---------------------------------------
%% J1 = dP/dDelta
%%---------------------------------------

J1 = zeros(m,m);

for i = 2:n

    for j = 2:n

        if i == j

            J1(i-1,j-1) = -Q(i) - B(i,i)*V(i)^2;

        else

            angle = delta(i) - delta(j);

            J1(i-1,j-1) = V(i)*V(j)*...
                (G(i,j)*sin(angle) - B(i,j)*cos(angle));

        end

    end

end

%disp('J1 Matrix')
%disp(J1)

%%---------------------------------------
%% J2 = dP/dV
%%---------------------------------------

J2 = zeros(m,m);

for i = 2:n

    for j = 2:n

        if i == j

            J2(i-1,j-1) = (P(i)/V(i)) + G(i,i)*V(i);

        else

            angle = delta(i) - delta(j);

            J2(i-1,j-1) = V(i)*...
                (G(i,j)*cos(angle) + B(i,j)*sin(angle));

        end

    end

end

%disp('J2 Matrix')
%disp(J2)

%%---------------------------------------
%% J3 = dQ/dDelta
%%---------------------------------------

J3 = zeros(m,m);

for i = 2:n

    for j = 2:n

        if i == j

            J3(i-1,j-1) = P(i) - G(i,i)*V(i)^2;

        else

            angle = delta(i) - delta(j);

            J3(i-1,j-1) = -V(i)*V(j)*...
                (G(i,j)*cos(angle) + B(i,j)*sin(angle));

        end

    end

end

%disp('J3 Matrix')
%disp(J3)

%%---------------------------------------
%% J4 = dQ/dV
%%---------------------------------------

J4 = zeros(m,m);

for i = 2:n

    for j = 2:n

        if i == j

            J4(i-1,j-1) = (Q(i)/V(i)) - B(i,i)*V(i);

        else

            angle = delta(i) - delta(j);

            J4(i-1,j-1) = V(i)*...
                (G(i,j)*sin(angle) - B(i,j)*cos(angle));

        end

    end

end

%disp('J4 Matrix')
%disp(J4)

%%---------------------------------------
%% Complete Jacobian Matrix
%%---------------------------------------

J = [

    J1   J2

    J3   J4

];

end