%--------------------------------------------------------------------------
% EE442 Introduction to Multimedia Signal Processing 
% Lab2 Image Representation
% YCbCr down and upsampling template
% Author: Binglai Niu and Adam Harrison
% -------------------------------------------------------------------------

%Edit this template to perform requirements for Question 4. Use it by:
%Im=imread('peppers.png');
%[RGB_2 RGB_4 RGB_8]=down_up_sample(Im);
function [RGB_2 RGB_4 RGB_8]=down_up_sample(Im)

% Convert RGB version of Im to an YCbCr version and seperate each component
    Im_Ycbcr = rgb2ycbcr(Im);
    Y = Im_Ycbcr(:,:,1);
    Cb = Im_Ycbcr(:,:,2);
    Cr = Im_Ycbcr(:,:,3);
% Chrominance downsampling by 2, 'bicubic'
    Cb_2 = imresize(Cb,0.5,'bicubic');
    Cr_2 = imresize(Cr,0.5,'bicubic');
% Chrominance upsampling by 2, 'bicubic'
    Cb_2 = imresize(Cb_2,2,'bicubic');
    Cr_2 = imresize(Cr_2,2,'bicubic');
    size(Cr_2)
% Create new YCbCr Image and convert back to RGB
    [height width depth]=size(Im_Ycbcr);
    Im_Ycbcr_2 = zeros(height,width,depth);
    Im_Ycbcr_2(:,:,1) = double(Y);
    Im_Ycbcr_2(:,:,2) = double(Cb_2);
    Im_Ycbcr_2(:,:,3) = double(Cr_2);    
    Im_Ycbcr_2 = uint8(Im_Ycbcr_2);

RGB_2= ycbcr2rgb(Im_Ycbcr_2);%save result to RGB_2

% Chrominance downsampling by 4, 'bicubic'
    Cb_4 = imresize(Cb,0.25,'bicubic');
    Cr_4 = imresize(Cr,0.25,'bicubic');
% Chrominance upsampling by 4, 'bicubic'
    Cb_4 = imresize(Cb_4,4,'bicubic');
    Cr_4 = imresize(Cr_4,4,'bicubic');
% Create new YCbCr Image and convert back to RGB
    Im_Ycbcr_4 = zeros(height,width,depth);
    Im_Ycbcr_4(:,:,1) = double(Y);
    Im_Ycbcr_4(:,:,2) = double(Cb_4);
    Im_Ycbcr_4(:,:,3) = double(Cr_4);    
    Im_Ycbcr_4 = uint8(Im_Ycbcr_4);


RGB_4= ycbcr2rgb(Im_Ycbcr_4);%save result to RGB_4

% Chrominance downsampling by 8, 'bicubic'
    Cb_8 = imresize(Cb,0.125,'bicubic');
    Cr_8 = imresize(Cr,0.125,'bicubic');
% Chrominance upsampling by 8, 'bicubic'
    Cb_8 = imresize(Cb_8,8,'bicubic');
    Cr_8 = imresize(Cr_8,8,'bicubic');
% Create new YCbCr Image and convert back to RGB
    Im_Ycbcr_8 = zeros(height,width,depth);
    Im_Ycbcr_8(:,:,1) = double(Y);
    Im_Ycbcr_8(:,:,2) = double(Cb_8);
    Im_Ycbcr_8(:,:,3) = double(Cr_8);    
    Im_Ycbcr_8 = uint8(Im_Ycbcr_8);

RGB_8= ycbcr2rgb(Im_Ycbcr_8);%save result to RGB_8


% Display the result
figure()
subplot(2,2,1),imshow(Im),title('Original Image');
subplot(2,2,2),imshow(RGB_2),title('Sampling factor=2');
subplot(2,2,3),imshow(RGB_4),title('Sampling factor=4');
subplot(2,2,4),imshow(RGB_8),title('Sampling factor=8');
