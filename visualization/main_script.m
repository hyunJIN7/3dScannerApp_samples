clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;


%% common setting to read text files

%
datasetPath = '../renaissance_plaza_scan/';
frameIndex =  831;


% read color, depth, and confidence image
colorImageFileName = [datasetPath sprintf('frame_%05d.jpg', frameIndex)];
depthImageFileName = [datasetPath sprintf('depth_%05d.png', frameIndex)];
confImageFileName = [datasetPath sprintf('conf_%05d.jpg', frameIndex)];

jsonTextFileName = [datasetPath sprintf('frame_%05d.json', frameIndex)];


%%


value = loadjson(jsonTextFileName);





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



