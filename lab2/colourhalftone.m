%--------------------------------------------------------------------------
% EE442 Introduction to Multimedia Signal Processing 
% Lab2 Image Representation
% Colour halftoning
% Author: and Adam Harrison and Binglai Niu
% -------------------------------------------------------------------------
%Edit this template to perform requirements for Question 6. Use it by:
%Im=imread('lenna.png');
%Im2=colourhalftone(Im);
function Im2=colourhalftone(Im)

[rows ,cols ,depth]=size(Im);
Im2=zeros(rows,cols,depth,'uint8');

% Extract C,M, and Y components from Im
R = Im(:,:,1); G = Im(:,:,2); B = Im(:,:,3);
C = 255 - R; M = 255 - G; Y = 255 - B;
% Process each component using Floyd-Steinberg method
C_new=myhalftone(C);
M_new=myhalftone(M);
Y_new=myhalftone(Y);

% Convert C_new, M_new, and Y_new back to RGB and save to Im2
R_new = 255 - C_new;
G_new = 255 - M_new;
B_new = 255 - Y_new;

Im2(:,:,1) = (R_new); 
Im2(:,:,2) = (G_new); 
Im2(:,:,3) = (B_new);
% display the original image
figure(1)
imshow(Im);       

% display the binary image
figure(2)
imshow(Im2); title('colour halftoned lenna');
end