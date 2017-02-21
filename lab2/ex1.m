Im  = imread('Flower.bmp');
R = Im(:,:,1); G = Im(:,:,2); B = Im(:,:,3);

%q2
B2 = imadjust(B,[0 0.5],[]);
ave_b2 = mean(B2(:));

%3
[height width depth]=size(Im);
nIm = zeros(height,width,depth);
nIm(:,:,1) = double(R); 
nIm(:,:,2) = double(G); 
nIm(:,:,3) = double(B2);
nIm = uint8(nIm);
figure(1); imshow(nIm);
figure(2); imshow(Im);

%% YCbCr 
peppers = imread('peppers.png');
[RGB_2 RGB_4 RGB_8]=down_up_sample(peppers);


%% Image halftoning
lena = imread('lenna.bmp');
lena_halftone=myhalftone(lena);