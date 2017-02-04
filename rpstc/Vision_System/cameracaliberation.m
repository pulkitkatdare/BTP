 close all
% clear all
clc; close all; clear all
cam=webcam('USB_Camera');
set(cam,'Resolution','1280x720')
load('cameraparameters.mat')
im=snapshot(cam);
imc=cell(4,1);

im=imcrop(im,[252.5 68.5 666 473]);
% imshow(im);
unim = undistortImage(im, cameraParams);
% figure;
imshow(unim);

p1=[638 103];
p2=[605 71];
p3=[643 70];
p4=[638 103]
angle=(atan2(-(p1(2)-p2(2)),(p1(1)-p2(1)))-atan2(-(p3(2)-p2(2)),(p3(1)-p2(1))))*180/pi

% imtool(im);
% imwrite(im,'61.png')
