clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath('jsonlab-2.0');
addpath(genpath(pwd));


% choose dataset directory from 3d scanner app
datasetPath = '../rgbd_dataset_renaissance_03_corridor01/';


%% plot 3D reconstruction and ARKit VIO results

% read 3D scanner app results
[ARKitPointsXYZ, ARKitPointsRGB] = readXYZ_colorFile(datasetPath, 1);
[stateEsti_ARKit, T_gc_ARKit] = readJsonFileCameraPose(datasetPath);


% plot 3D estimated trajectory with 3-D reconstruction results
figure;
set(gcf,'color','w'); hold on; axis equal; axis off; view(0,0);
set(gcf,'Units','pixels','Position',[500 20 1400 1000]);

% draw 3-D reconstruction results
numPoints = length(ARKitPointsXYZ);
scatter3(ARKitPointsXYZ(1,:), ARKitPointsXYZ(2,:), ARKitPointsXYZ(3,:), 100*ones(numPoints,1), (ARKitPointsRGB ./ 255).','.');

% draw camera frame
L = 0.5; % coordinate axis length
A = [0 0 0 1; L 0 0 1; 0 0 0 1; 0 L 0 1; 0 0 0 1; 0 0 L 1]';
for k = 1:10:length(T_gc_ARKit)
    
    % camera frame (x-y-z)
    T = T_gc_ARKit{k};
    B = T * A;
    plot3(B(1,1:2),B(2,1:2),B(3,1:2),'-r','LineWidth',1);    % x: red
    plot3(B(1,3:4),B(2,3:4),B(3,3:4),'-g','LineWidth',1);   % y: green
    plot3(B(1,5:6),B(2,5:6),B(3,5:6),'-b','LineWidth',1);   % z: blue
    
    % camera frame frustum
    plot_camera_frame_black_only(T_gc_ARKit{k}(1:3,1:3), T_gc_ARKit{k}(1:3,4), 1.0, 'k');
end

% draw ARKit 3D trajectory
plot3(stateEsti_ARKit(1,:),stateEsti_ARKit(2,:),stateEsti_ARKit(3,:),'r','LineWidth',2.5);
plot_inertial_frame(5.0); axis equal; axis on; grid on; view(0,0);
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');

% figure options
f = FigureRotator(gca());





