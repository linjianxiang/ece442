%%  question 1
Im = imread('lenna.bmp');
[height,width] = size(Im);

imwrite(Im, 'lenna.jpg');
%imshow(Im);
Cc = 32637;  %bytes 
C0 = 263222;  %bytes

C0/Cc

%% question 2

slm = Im(1:2:height,1:2:width);
subplot(2,1,1);
imshow(slm); title('top left pixel of each block');

meanslm = uint8(blkproc(Im,[2 2],'mean2'));
subplot(2,1,2);
imshow(meanslm); title('average of the 4 pixels');

% Images are similar, it is not easy to distinguish the difference
% however, the mean method is more smoth pLenWindow=2^15; 
LenOverlap = 0; 
LenNonOverlap = LenWindow - LenOverlap; 
NumSegCh2 = floor( (length(LowRecMusicCh2)-LenWindow)/LenNonOverlap)+1; 
for iseg = 1 : NumSegCh2 
    seg_start = (iseg-1)*LenNonOverlap + 1; seg_end = seg_start + LenWindow - 1; 
    LowRecMusicCh2(seg_start:seg_end) = ... 
flipud(LowRecMusicCh2(seg_start:seg_end)); 
end 
sound(LowRecMusicCh2, Fs, LowNbits); roduced smoother image

%% question 3

nnulm = uint8(kron(double(meanslm),ones(2)));
imshow(nnulm);

% there are clearly block pixels on the eadge.
% becuase that if upsampling k times, each pixel in the original image
% is copied and put into k pixels to sampled image. or one pixel value
% becomes four pixels value on upsampled image

%% question 4
scale = 2;

nearest_m = imresize(meanslm,scale,'nearest');
subplot(2,1,1);
imshow(nearest_m); title('nearest neighbor interpolation');

bculm = imresize(meanslm,scale,'bicubic');
subplot(2,1,2);
imshow(bculm); title('bicubic interpolation');

% the bicubic interpolation produced smoother image
% the nearest method uses the nearest pixel during scalling
% but for the bicubic, the interpolation uses linear relationship to
% calculate pixel values

%% question 5

[blm] = show_bit_image(Im,8);
% from MSB to LSB the image imformation decreases. for example we can still
% identify the image int the 8th 7th 6th
% bit plan, but for bit level lower than 6th most of image is noise

%% question 6 

lenna_emb = imread('lenna_embed.bmp');
LSB_emb = bitget(lenna_emb, 1);
imshow(LSB_emb,[]);

%% qeustion 7

[x,y] = size(lenna_emb);
lenna_swap = zeros(x,y);
% the secret is, three university of alberta logo
for i = 2:8;
    blm_emb = bitget(lenna_emb,i);
    lenna_swap = lenna_swap + double(blm_emb * 2^(i-1));
end
lenna_swap = lenna_swap + double(bitget(lenna_emb,1) * 2^(7));
imshow(lenna_swap,[]); title('swaped image');

% there are three ualberta logo on the lenna image

%% question 8

[Music,Fs] = audioread('symphonic.wav');
[MusicLength, NumChannel] = size(Music);
sound(Music,Fs)
subplot(2,1,1);plot(Music(:,1)); title('First Channel');
subplot(2,1,2);plot(Music(:,2)); title('Second Channel');

%%
Nbits = 16;
LowNbits = 8;
IntMusic = uint16((Music+1) * 2^(Nbits-1));

%channel one
LowIntMusicCh1 = uint16(zeros(MusicLength,1));
FirstChannel = IntMusic(:,1);
for ibit = 1 : LowNbits
    LowIntMusicCh1 = LowIntMusicCh1 + bitget(FirstChannel,ibit)*2^(ibit-1);
end

LowRecMusicCh1 = double(LowIntMusicCh1)/2^(LowNbits-1)-1;
sound(LowRecMusicCh1,Fs,LowNbits);
%%
%channel two 
LowIntMusicCh2 = uint16(zeros(MusicLength,1));
SecondChannel = IntMusic(:,2);
for ibit = 1 : LowNbits
    LowIntMusicCh2 = LowIntMusicCh2 + bitget(SecondChannel,ibit)*2^(ibit-1);
end
LowRecMusicCh2 = double(LowIntMusicCh2)/2^(LowNbits-1)-1;
sound(LowRecMusicCh2,Fs,LowNbits);

% at the begining there is someone saying something and flows claps and in the end is a very short song 

%% question 9
LenWindow=2^15; 
LenOverlap = 0; 
LenNonOverlap = LenWindow - LenOverlap; 
NumSegCh2 = floor( (length(LowRecMusicCh2)-LenWindow)/LenNonOverlap)+1; 
for iseg = 1 : NumSegCh2 
    seg_start = (iseg-1)*LenNonOverlap + 1; seg_end = seg_start + LenWindow - 1; 
    LowRecMusicCh2(seg_start:seg_end) = ... 
flipud(LowRecMusicCh2(seg_start:seg_end)); 
end 
sound(LowRecMusicCh2, Fs, LowNbits); 

%great job - claps - welcome to this program - music 