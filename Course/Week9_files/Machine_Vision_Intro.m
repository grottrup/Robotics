%% Introduction script to Machine Vision
clear
im = imread('foto3b.jpg');

imtool(im) % analyze image


%% Edge-based segmentation and finding orientation
% im = im_test; % TESTING
imgray = rgb2gray(im);
imshow(imgray)

% Edge detection.. (canny method)
imbw = edge(imgray,'canny');
imshow(imbw)

% analysis of edges..
subplot(211), plot(imgray(450:520, 400))
subplot(212), imshow(imgray), hold on, line([400 400], [450 520], 'Color', 'r')

subplot(211), plot(imgray(580:740, 450))
subplot(212), imshow(imgray), hold on, line([450 450], [580 740], 'Color', 'r')

subplot(211), plot(imgray(520, 640:740))
subplot(212), imshow(imgray), hold on, line([640 740], [520 520], 'Color', 'r')


% Hough transform
[H,theta,rho] = hough(imbw);
imagesc([theta(1) theta(end)], [rho(1) rho(end)], H)
xlabel('\theta'), ylabel('\rho');

% Finding peaks
peaks  = houghpeaks(H,20); % 10 peaks

% Finding lines
imtool(imgray) % analyze to see distances..
lines = houghlines(imbw,theta,rho,peaks,'FillGap',5,'MinLength',40);

% plot image + lines
imshow(imgray), hold on
for i=1:length(lines),
    xy = [lines(i).point1; lines(i).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','red');
end
title(['Number lines : ' num2str(length(lines))])



%% Color-based segmentation and finding center position
imR = im(:,:,1); % red channel
imshow(imR)

imG = im(:,:,2); % green channel
imshow(imG)

imB = im(:,:,3); % blue channel
imshow(imB)

I = imR > (imG + imB); % possible solution ?
imagesc(I)

myStats = regionprops(I, 'Area', 'Centroid'); % finding properties of connected components..
% showing components
I2 = bwlabel(I);
imshow(label2rgb(I2))

% Plot original image with center of brick
myCenter = myStats(1).Centroid;
imshow(im)
hold on
plot(myCenter(1), myCenter(2), 'k.', 'MarkerSize', 30)


%% Alternative tool..
colorThresholder(im)

im_test = imread('foto1.jpg');
[BW,maskedRGBImage] = myCreateMask(im_test);
imshowpair(BW, maskedRGBImage, 'montage')


