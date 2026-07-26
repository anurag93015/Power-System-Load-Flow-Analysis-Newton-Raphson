function Ybus = create_ybus(lineData)

%----------------------------------------
% Create Y-Bus Matrix
%----------------------------------------

numBus = max(max(lineData(:,1:2)));

Ybus = zeros(numBus);

for k = 1:size(lineData,1)

    from = lineData(k,1);
    to   = lineData(k,2);

    R = lineData(k,3);
    X = lineData(k,4);

    Z = R + 1i*X;
    Y = 1/Z;

    % Diagonal Elements
    Ybus(from,from) = Ybus(from,from) + Y;
    Ybus(to,to)     = Ybus(to,to) + Y;

    % Off-Diagonal Elements
    Ybus(from,to) = Ybus(from,to) - Y;
    Ybus(to,from) = Ybus(to,from) - Y;

end

end