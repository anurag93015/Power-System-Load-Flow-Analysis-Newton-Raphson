function save_results(V, delta)

%---------------------------------------------------------
% Save Load Flow Results to Results Folder
%---------------------------------------------------------

% Get project root folder
projectRoot = fileparts(pwd);

% Create Results folder path
resultFolder = fullfile(projectRoot,'Results');

% Create Results folder if it doesn't exist
if ~exist(resultFolder,'dir')
    mkdir(resultFolder);
end

% Create output file
fileName = fullfile(resultFolder,'load_flow_results.txt');

fileID = fopen(fileName,'w');

% Check if file opened successfully
if fileID == -1
    error('Unable to create output file.');
end

fprintf(fileID,'===============================================\n');
fprintf(fileID,'      POWER SYSTEM LOAD FLOW RESULTS\n');
fprintf(fileID,'===============================================\n\n');

fprintf(fileID,'Bus\tVoltage (p.u.)\tAngle (Degree)\n');
fprintf(fileID,'-----------------------------------------------\n');

for i = 1:length(V)

    fprintf(fileID,'%d\t\t%.4f\t\t%.4f\n', ...
        i, V(i), rad2deg(delta(i)));

end

fprintf(fileID,'-----------------------------------------------\n');

fclose(fileID);

disp(' ');
disp('===============================================');
disp('Results saved successfully!');
disp(['Location : ', fileName]);
disp('===============================================');

end