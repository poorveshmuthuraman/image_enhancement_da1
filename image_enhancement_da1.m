clear all;
clc

RGB = imread('peppers.png');

%grayscale
I = rgb2gray(RGB);
figure
imshow(I)


%edges
BW1 = edge(I,'Canny');
BW2 = edge(I,'Prewitt');
imshowpair(BW1,BW2,'montage')

% %histogram
figure
subplot(1,3,1)
imshow(I)
subplot(1,3,2:3)
imhist(I)

% Equilization
J = histeq(I);
figure
subplot(2,3,1)
imshow(I)
subplot(2,3,2:3)
imhist(I)
subplot(2,3,4)
imshow(J)
subplot(2,3,5:6)
imhist(J)

% BW image and Invert
BWimage = imbinarize(I);
figure
imshowpair(I,BWimage,'montage')
InvertedBW = imcomplement(BWimage);
imshowpair(BWimage,InvertedBW,'montage')

% add and subtract
add = imadd(RGB, 50);
sub = imsubtract(RGB,50);
figure
imshowpair(add,sub,'montage')


% Suggested Changes

% Noise
subplot(3, 1, 1)
imshow(RGB)
title('Original Image');

I=imnoise(RGB,'salt & pepper',0.1);
subplot(3, 1, 2)
imshow(I)
title('Image with Salt & Pepper Noise');

se=ones(3,3);
I2= imclose(imopen(I,se),se);
subplot(3, 1, 3)
imshow(I2); 
title('Morphologically Filtered Image');

% Sharppening and blurring


blurredImg = imgaussfilt(RGB, 2);
sharpenedImg = imsharpen(blurredImg);

subplot(1, 2, 1) 
imshow(blurredImg) 
title('Blurred image');
subplot(1, 2, 2) 
imshow(sharpenedImg) 
title('Sharpened Image');





% BRISQUE Score


contrastImg = imadjust(RGB,stretchlim(RGB));
sharpenedImg = imsharpen(RGB);;
histImg = histeq(RGB);

fprintf("Image score (NIQE)\nContrast stretched image: %0.2f.\nSharpening: %0.2f\nHistogram: %0.2f", niqe(contrastImg), niqe(sharpenedImg), niqe(histImg))
fprintf("Image score (BRISQUE)\nContrast stretched image: %0.2f.\nSharpening: %0.2f\nHistogram: %0.2f", brisque(contrastImg), brisque(sharpenedImg), brisque(histImg))



