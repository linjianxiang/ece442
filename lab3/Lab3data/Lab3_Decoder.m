%Use this function as a template for your Lab 3 decoder function
%The function should assume that Y.jpg, Y.txt, Cb.jpg, Cb.txt, Cr.jpb, 
%Cr.txt files are saved in the current directory
%The function should return a decoded 'Im' RGB image. It should also make
%no assumptions on the size of the image components (ie, obtain dimensions
%from the output of JPEG_entropy_decode

function Im=Lab3_Decoder()

%rename the saved output of Y.jpg and Y.txt to the expected naming
%convention

%call JPEG_entropy_decode to obtain matrix of flattened 8x8 blocks and
%quantization table (see the header of the function for details on the return
%values it outputs)

%execute unflattening on each row of the zigzag-flattened matrix

%use Luminance quantization table to reverse quantization of luminance 
%of each 8x8 blocks

%Perform idct transform on 8x8 blocks

%uncenter data values, and perform resizing of component image if necessary

%repeat above steps for Cb and Cr

%convert components to RGB, and return them in the Im variable



%repeat steps for chrominance components, but use the Chrominance
%quantization table instead




