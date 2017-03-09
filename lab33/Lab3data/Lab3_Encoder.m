%Use this function as a template for your Lab 3 encoder function
%The parameter 'Im' should be a colour RGB image
%The function doesn't need to return anything, but should save Y.jpg,
%Y.txt, Cb.jpg, Cb.txt, Cr.jpb, Cr.txt files in the current directory
%It should also make no assumptions on the size of the image 
%(ie, obtain dimensions from input image)
function Lab3_Encoder(Im)

%extract Y, Cb, Cr components from Imtext_filename
ycbcrmap = rgb2ycbcr(Im);
Y = ycbcrmap(:,:,1);
Cb = ycbcrmap(:,:,2);
Cr = ycbcrmap(:,:,3);

%center data values, and perform resizing of component images if necessary
%level shifting
Y = double(Y);
Cb = double(Cb);
Cr = double(Cr);
Y = Y -128;
Cb = Cb - 128;
Cr = Cr - 128;
%downsampleY
Cb_2 = imresize(Cb, 0.5);
Cr_2 = imresize(Cr, 0.5);
%Perform dct transform on 8x8 blocks
fun = @dct2;
Y_dct = blkproc(Y,[8,8],fun);
Cb_dct = blkproc(Cb_2,[8,8],fun);
Cr_dct = blkproc(Cr_2,[8,8],fun);

%use Luminance quantization table to quantize luminance values of 8x8
%blocks
fun_2 = @(Y_block)round(Y_block./JpegLumQuanTable());
fun_3 = @(Y_block)round(Y_block./JpegChrQuanTable());
Qy = blkproc(Y_dct,[8,8],fun_2);
Qcb = blkproc(Cb_dct,[8,8],fun_3);
Qcr = blkproc(Cr_dct,[8,8],fun_3);
%execute zigzag flattening on each 8x8 block
[my,ny]=size(Y);
Y_z=zeros (my/8*ny/8,8*8);
N2=1;
for i=1:8:my
    for j=1:8:ny
          Y_z(N2,:)=ZigzagMtx2Vector(Qy(i:i+7,j:j+7));
          N2=N2+1;
    end
end

[mcb,ncb]=size(Cb_2);
Y_cb=zeros(mcb/8*ncb/8,8*8);
N2=1;
for i=1:8:mcb
    for j=1:8:ncb
          Y_cb(N2,:)=ZigzagMtx2Vector(Qcb(i:i+7,j:j+7));
          N2=N2+1;
    end
end

[mcr,ncr]=size(Cr_2);
Y_cr=zeros(mcr/8*ncr/8,8*8);
N2=1;
for i=1:8:mcr
    for j=1:8:ncr
          Y_cr(N2,:)=ZigzagMtx2Vector(Qcr(i:i+7,j:j+7));
          N2=N2+1;
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

lenY = JPEG_entropy_encode(my,ny,8,JpegLumQuanTable(),Y_z,0,pwd,Y_text_filename,Y_jpg_filename);
lenCb = JPEG_entropy_encode(mcb,ncb,8,JpegChrQuanTable(),Y_cb,1,pwd,Cb_text_filename,Cb_jpg_filename);
lenCr = JPEG_entropy_encode(mcr,ncr,8,JpegChrQuanTable(),Y_cr,1,pwd,Cr_text_filename,Cr_jpg_filename);




