

%% check normals of great circles distribution

%
imageCurForLine = grayImage;

fx = value.intrinsics(1);
fy = value.intrinsics(5);
cx = value.intrinsics(6);
cy = value.intrinsics(3);

cam_color.K = eye(3);
cam_color.K(1,1) = fx;
cam_color.K(1,3) = cx;
cam_color.K(2,2) = fy;
cam_color.K(2,3) = cy;
cam_color.K_pyramid(:,:,1) = cam_color.K;

cam_color.k1 = 0;
cam_color.k2 = 0;
cam_color.k3 = 0;
cam_color.p1 = 0;
cam_color.p2 = 0;

optsMWMS.lineDetector = 'lsd';
optsMWMS.lineLength = 150;


% detect lines and related line normals
[lines, ~, lineNormals] = extractLinesAndGreatcircle(imageCurForLine, cam_color, optsMWMS);
lineNormals = lineNormals.';

% plot image with lines / Gaussian sphere with line normals, vDD
figure;
imshow(imageCurForLine, []); hold on;
for i = 1:size(lines,1)
    plot([lines(i,1),lines(i,3)],[lines(i,2),lines(i,4)],'LineWidth',2.5);
end

figure;
plot_unit_sphere(1, 20, 0.5); hold on; grid on; axis equal;
plot_line_normals_unit_sphere(imageCurForLine, cam_color, optsMWMS);

plot_vertical_dominant_direction(R_cM(:,1), 'r', 0.01);
plot_vertical_dominant_direction(R_cM(:,2), 'g', 0.01);
plot_vertical_dominant_direction(R_cM(:,3), 'b', 0.01);
plot_vertical_dominant_plane(R_cM(:,1), 3.0, 'r');
plot_vertical_dominant_plane(R_cM(:,2), 3.0, 'g');
plot_vertical_dominant_plane(R_cM(:,3), 3.0, 'b');


%% surface normal to the ground plane

%
depthImage(confImage == 0) = 0;
imageCurForMW = grayImageResized;
depthCurForMW = double(depthImage) ./ 1000;

cam_depth.K = eye(3);
cam_depth.K(1,:) = cam_color.K(1,:) / (1440/192);
cam_depth.K(2,:) = cam_color.K(2,:) / (1920/256);
cam_depth.K_pyramid(:,:,1) = cam_depth.K;

optsMWMS.imagePyramidLevel = 1;
optsMWMS.minimumDepth = 0.4;
optsMWMS.maximumDepth = 6;
optsMWMS.planeInlierThreshold = 0.02;
optsMWMS.cellsize = 10;
optsMWMS.minSampleRatio = 0.15;

optsMWMS.numInitialization = 200;
optsMWMS.iterNum = 200;
optsMWMS.convergeAngle = deg2rad(0.001);
optsMWMS.halfApexAngle = deg2rad(10);
optsMWMS.c = 20;
optsMWMS.ratio = 0.1;


% surface normal vector
[sNV, sPP] = estimateSurfaceNormalGradient(imageCurForMW, depthCurForMW, cam_depth, optsMWMS);


% initialize and seek the dominant MF
[MF_can, FindMF] = seekManhattanWorld(sNV, optsMWMS);
R_cM = ClusterMMF(MF_can, optsMWMS.ratio);
R_cM = R_cM{1};


figure;
plot_segmentation_image(R_cM, sNV, sPP, imageCurForMW, optsMWMS);


figure;
plot_sphere_compass(R_cM, sNV, optsMWMS);
view(-1, -71);


% % detect dominant plane and surface normals
% [pNV, ~] = estimatePlaneNormalRANSAC(imageCur, depthCur, cam_color, optsMWMS);
% [sNV, sPP] = estimateSurfaceNormalGradient(imageCur, depthCur, cam_color, optsMWMS);
% surfaceNormalVector = sNV;
% surfacePixelPoint = sPP;
%
%
% % refine plane normal vector
% [pNV, isTracked] = trackSinglePlane(pNV, sNV, optsMWMS);






