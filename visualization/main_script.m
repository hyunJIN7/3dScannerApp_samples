clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath('jsonlab-2.0');
addpath('lsd_1.6');
addpath(genpath(pwd));


%% common setting to read 3D Scanner App data

%
datasetPath = '../renaissance_plaza_scan/';
frameIndex =  831;


% read color, depth, and confidence image
colorImageFileName = [datasetPath sprintf('frame_%05d.jpg', frameIndex)];
depthImageFileName = [datasetPath sprintf('depth_%05d.png', frameIndex)];
confImageFileName = [datasetPath sprintf('conf_%05d.png', frameIndex)];

jsonTextFileName = [datasetPath sprintf('frame_%05d.json', frameIndex)];


%%

% iOS camera parameters
value = loadjson(jsonTextFileName);


% color image
colorImage = imread(colorImageFileName);
colorImage = imrotate(colorImage,-90);
grayImage = rgb2gray(colorImage);


figure;
imshow(colorImage,[]);


% depth image
depthImage = imread(depthImageFileName);
depthImage = imrotate(depthImage,-90);


figure;
imshow(depthImage,[]);


% confidence image
confImage = imread(confImageFileName);
confImage = imrotate(confImage,-90);


figure;
imshow(confImage,[]);


%%


colorImageResized = imresize(colorImage,[256 192]);

figure;
imshow(colorImageResized,[]);


%%

1024

grayImageResized = imresize(grayImage,[256 192]);

1920 1440
256 192











