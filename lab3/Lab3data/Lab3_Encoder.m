%Use this function as a template for your Lab 3 encoder function
%The parameter 'Im' should be a colour RGB image
%The function doesn't need to return anything, but should save Y.jpg,
%Y.txt, Cb.jpg, Cb.txt, Cr.jpb, Cr.txt files in the current directory
%It should also make no assumptions on the size of the image 
%(ie, obtain dimensions from input image)
function Lab3_Encoder(name)
Im = imread(name);
%extract Y, Cb, Cr components from Im
Im_y = rgb2ycbcr(Im);
Im_y = double(Im_y);
Im_y = Im_y - 128;
Y = Im_y(:,:,1);
Cb = Im_y(:,:,2);
Cr = Im_y(:,:,3);

%center data values, and perform resizing of component images if necessary
Cb_down = imresize(Cb,0.5);
Cr_down = imresize(Cr,0.5);
%Perform dct transform on 8x8 blocks
fun_dct = @dct2;
Y_dct = blkproc(Y,[8,8],fun_dct);
Cb_dct = blkproc(Cb_down,[8,8],fun_dct);
Cr_dct = blkproc(Cr_down,[8,8],fun_dct);

%use Luminance quantization table to quantize luminance values of 8x8
%blocks

fun_lum = @(Y_block)round(Y_block./JpegLumQuanTable());
fun_chrom = @(Y_block)round(Y_block./JpegChrQuanTable());
Y_q= blkproc(Y_dct,[8 8],fun_lum);
Cb_q= blkproc(Cb_dct,[8 8],fun_chrom);
Cr_q= blkproc(Cr_dct,[8 8],fun_chrom);

%execute zigzag flattening on each 8x8 block 
[my,ny] = size(Y_q);
Y_z = zeros(my/8*ny/8,8*8);
N2 = 1;
for i = 1:8:my
    for j = 1:8:ny
        Y_z(N2,:) = ZigzagMtx2Vector( Y_q(i:i+7,j:j+7));
        N2 = N2+1;
    end
end

[my,ny] = size(Cr_q);
Cr_z = zeros(my/8*ny/8,8*8);
Cb_z = zeros(my/8*ny/8,8*8);
N2 = 1;
for i = 1:8:my
    for j = 1:8:ny
        Cr_z(N2,:) = ZigzagMtx2Vector(Cr_q(i:i+7,j:j+7));
        Cb_z(N2,:) = ZigzagMtx2Vector(Cb_q(i:i+7,j:j+7));
        N2 = N2+1;
    end
end
%call JPEG_entropy_encode on matrix of flattened 8x8 blocks (see
%presentation and the function header for details on calling this function 
%properly)

%rename the saved output of JPEG_entropy_encode using the proper naming
%convention
Y_text_filename='Y.txt';
Y_jpg_filename='Y.jpg';
Cb_text_filename='Cb.txt';
Cb_jpg_filename='Cb.jpg';
Cr_text_filename='Cr.txt';
Cr_jpg_filename='Cr.jpg';

%repeat steps for chrominance components, but use the Chrominance
%quantization table instead
lenY = JPEG_entropy_encode(my,ny,8,JpegLumQuanTable(),Y_z,0,pwd,Y_text_filename,Y_jpg_filename);
lenCb = JPEG_entropy_encode(mcb,ncb,8,JpegChrQuanTable(),Cb_z,1,pwd,Cb_text_filename,Cb_jpg_filename);
lenCr = JPEG_entropy_encode(mcr,ncr,8,JpegChrQuanTable(),Cr_z,1,pwd,Cr_text_filename,Cr_jpg_filename);



end

