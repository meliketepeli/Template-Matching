clc 
clear all;

% B PART converting 8-bits grey level image.

eightBit= imread('shape.bmp');
eightBitImage = rgb2gray(eightBit);
figure
imshow(eightBitImage);

% C PART calculating and plotting the normalized cross correlation image

myTemplate = imread("myTemplateImage.png");
figure
imshow(myTemplate);
figure
imshow(eightBitImage);

crossC = normxcorr2(myTemplate, eightBitImage);
figure
imshow(crossC, []);
title('Cross Correlation Image');

% D PART good maximums of ncc

thresh = 0.8;

peak = crossC > thresh;

[peakLabels, numPeak] = bwlabel(peak);

peakCent = regionprops(peakLabels, 'Centroid');
center = cat(1, peakCent.Centroid);

disp('    Center -> (x, y):');
disp(center);

% E PART drawing (+) using text func.

figure;
imshow(eightBitImage, []);
hold on;

for i = 1:size(center, 1)
    text(center(i,1), center(i,2), '+', 'Color', 'magenta', 'FontSize', 12, 'HorizontalAlignment', 'center');
end
title('Hexagon Centers Marked with "+"');
hold off;

% F PART displaying number of hexagons

disp(['Hexagon Number: ', num2str(numPeak)]);

text(10, 10, ['Count: ', num2str(numPeak)], 'Color', 'blue', 'FontSize', 10, 'BackgroundColor', 'white');