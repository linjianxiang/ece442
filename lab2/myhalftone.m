%--------------------------------------------------------------------------
% EE442 Introduction to Multimedia Signal Processing 
% Lab2 Image Representation
% Halftoning
% Author: Adam Harrison
% -------------------------------------------------------------------------
%Edit this template to perform requirements for Question 5. Use it by:
%Im=imread('lenna.bmp');
%Im2=myhalftone(Im);
function Im2=myhalftone(Im) 

close all
Im_double=double(Im);		    % convert to double precision before processing
[rows,cols] = size(Im_double);	% # of rows and columns
Im2 = zeros(rows,cols);	% initialization of the binary image
Im_double2 = zeros(rows+2, cols+2);
Im_double2(2:rows+1,2:cols+1) = Im_double;
for i = 1 : rows		% processing the pixels in the raster scan order 
	for j = 1 : cols
        
        % set Im2(i,j) to the appropriate binary value based on Im_double
		if Im_double2(i+1,j+1) < 128
            Im2(i,j) = 0;
        else
            Im2(i,j) = 255;
        end
		% compute the quantization error 
        e = Im_double2(i+1,j+1) - Im2(i,j);
		% diffuse the quantization error to neighboring pixels of Im_double
        Im_double2(i+1,j+2) = Im_double2(i+1,j+2) + e * 7/16;
        Im_double2(i+2,j) = Im_double2(i+2,j) + e * 3/16;
        Im_double2(i+2,j+1) = Im_double2(i+2,j+1) + e * 5/16;
        Im_double2(i+2,j+2) = Im_double2(i+2,j+2) + e * 1/16;
	end
end
Im2=uint8(Im2); %cast back to unsigned 8-bit integers


% display the original image
figure(1)
imshow(Im);       

% display the binary image
figure(2)
imshow(Im2); title('halftoned lean');
end

