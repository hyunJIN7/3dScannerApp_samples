



fx = value.intrinsics(1);
fy = value.intrinsics(5);
cx = value.intrinsics(6);
cy = value.intrinsics(3);

cam.K = eye(3);
cam.K(1,1) = fx;
cam.K(1,3) = cx;
cam.K(2,2) = fy;
cam.K(2,3) = cy;

cam.K(1,:) = cam.K(1,:) / (1440/192);
cam.K(2,:) = cam.K(2,:) / (1920/256);


cam.K


points = zeros(3,256*192);
colors = zeros(3,256*192);
count = 0;
for v = 1:256
    for u = 1:192
        count = count + 1;
        points(:,count) = (inv(cam.K) * [u;v;1]) * (double(depthImage(v,u)) / 1000);
        colors(:,count) = squeeze(colorImageResized(v,u,:));
    end
end


figure;
scatter3(points(1,:), points(2,:), points(3,:),30*ones(1,49152),(colors/255).'); axis equal;












%%


% line detection
imageCurForLine = grayImage;
lineLength = 150;

dimageCurForLine = double(imageCurForLine);
[lines, ~] = lsdf(dimageCurForLine, (lineLength^2));
% lines = extractUniqueLines(imageCurForLine, lines, cam);


% plot image with lines / Gaussian sphere with line normals, vDD
figure;
imshow(imageCurForLine, []); hold on;
for i = 1:size(lines,1)
    plot([lines(i,1),lines(i,3)],[lines(i,2),lines(i,4)],'LineWidth',2.5);
end


%%



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


%%

clc;
clear all;

colorImage = imread('frame_00831.jpg');
grayImage = rgb2gray(colorImage).';
grayImage = flip(grayImage,2);
grayImageResized = imresize(grayImage,[256 192]);

depthImage = imread('depth_00831.png').';
depthImage = flip(depthImage,2);


figure;
imshow(grayImage,[]);


figure;
imshow(grayImageResized,[]);

figure;
imshow(depthImage,[]);



%%

1024



1920 1440



256 192
