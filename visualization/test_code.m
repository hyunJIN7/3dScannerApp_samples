



filename = 'Untitled_Scan_19_25_13.txt';
textData = importdata(filename, ',');

numPoints = size(textData,1);
ARKitPointsXYZ = textData(:,1:3).';
ARKitPointsRGB = textData(:,4:6).';



figure;
scatter3(ARKitPointsXYZ(1,:), ARKitPointsXYZ(2,:), ARKitPointsXYZ(3,:), 50*ones(numPoints,1), (ARKitPointsRGB ./ 255).','.');

axis equal;
xlabel('x [m]','fontsize',10); ylabel('y [m]','fontsize',10); zlabel('z [m]','fontsize',10);

% figure options
f = FigureRotator(gca());


%%

temp = imread('../Untitled_Scan_19_27_01_All_Data/2022_02_07_14_03_31/conf_00294.png');

figure;
imshow(temp,[]);