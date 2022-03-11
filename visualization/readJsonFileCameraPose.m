function [stateEsti_ARKit, T_gc_ARKit] = readJsonFileCameraPose(datasetPath)

% read json file list
jsonFileDir = [datasetPath 'All_Data/'];
jsonFileList = dir([jsonFileDir '*.json']);
jsonFileList(end) = [];


% ARKit camera pose with various 6-DoF camera pose representations
numJsonFile = size(jsonFileList,1);
T_gc_ARKit = cell(1,numJsonFile);
stateEsti_ARKit = zeros(6,numJsonFile);
R_gc_ARKit = zeros(3,3,numJsonFile);
for k = 1:numJsonFile
    
    % rigid body transformation matrix (4x4)
    jsonObject = loadjson([jsonFileDir jsonFileList(k).name]);
    T_gc_ARKit{k} = reshape(jsonObject.cameraPoseARFrame, 4, 4).';
    
    % state vector and rotation matrix
    R_gc_ARKit(:,:,k) = T_gc_ARKit{k}(1:3,1:3);
    stateEsti_ARKit(1:3,k) = T_gc_ARKit{k}(1:3,4);
    [yaw, pitch, roll] = dcm2angle(R_gc_ARKit(:,:,k));
    stateEsti_ARKit(4:6,k) = [roll; pitch; yaw];
end


end


% % move trajectory to the origin
% startingPoint = stateEsti_ARKit(1:3,1);
% stateEsti_ARKit(1,:) = stateEsti_ARKit(1,:) - startingPoint(1);
% stateEsti_ARKit(2,:) = stateEsti_ARKit(2,:) - startingPoint(2);
% stateEsti_ARKit(3,:) = stateEsti_ARKit(3,:) - startingPoint(3);
% for k = 1:numJsonFile
%     T_gc_ARKit{k}(1:3,4) = T_gc_ARKit{k}(1:3,4) - startingPoint;
% end
