function [Len] = JPEG_entropy_encode(rowN, colN, dct_block_size, Q, ZZDCTQIm, chrom_flag, encoder_path,text_filename,jpg_filename)

% function [Len] = JPEG_entropy_encode(rowN, colN, dct_block_size, Q, ZZDCTQIm, chrom_flag, encoder_path)
% JPEG Entropy Encoder
% Input:
%      rowN: scalar: number of rows in the ORIGINAL image
%      colN: scalar: number of columns in the ORIGINAL image
%      dct_block_size: scalar: the dimension of square blocks used in the DCT
%      Q: dct_block_sizexdct_block_size : quantization table used
%      ZZDCTQIm: (rowN*colN/dct_block_size^2)x(dct_block_size^2) : the zigzagged quantized matrix
%      chrom_flag: scalar: 0 or 1; 1 indicates that the matrix represents
%      chrominance (better compression achieved with appropriate flag)
%      encoder_path: string: the absolute path where this .m and JPEG_Encoder reside
% Output:
%      Len: scalar: compressed file length
%
% Author: Guan-Ming Su
% Date: 8/1/02
% Significant modifications by Emil Wyrod
% Date: 2013-03-09

% initial checking for input arguments
if(nargin==7)
   jpg_filename='JPEG.jpg';
   text_filename='JPEG_DCTQ_ZZ.txt';
end
if encoder_path(end)~='\' && encoder_path(end)~= '/'
    encoder_path=[encoder_path '/'];
end
rowblkN = rowN/dct_block_size;
colblkN = colN/dct_block_size;  
[d1,d2] = size(Q);
if (d1~=dct_block_size) | (d2~=dct_block_size)
    error('Dimensions of Quantization Table should be dct_block_size x dct_block_size ');
end  
    
% open file
text_filename=strcat(encoder_path,text_filename);
jpg_filename=strcat(encoder_path,jpg_filename);
[fid_out,message] = fopen(text_filename,'w');
% write comment
fprintf(fid_out,'%s\n','# Text-intermediate for zigzag-YCbCr file used by JPEG_Encoder. Author: Emil Wyrod  Date: 2013-03-09');
% write information for encoding
fprintf(fid_out,'%s\n','image_rows');             fprintf(fid_out,'%s\n', num2str(rowN));
fprintf(fid_out,'%s\n','image_cols');             fprintf(fid_out,'%s\n', num2str(colN));
fprintf(fid_out,'%s\n','DCT_block_size');   fprintf(fid_out,'%s\n',num2str(dct_block_size));
fprintf(fid_out,'%s\n','is_chrom');   fprintf(fid_out,'%s\n',num2str(chrom_flag));
% write Quantization Table
fprintf(fid_out,'%s\n','QT');
for i=1:1:dct_block_size
   for j=1:1:dct_block_size
      fprintf(fid_out,'%s ',num2str(Q(i,j)));
   end
     fprintf(fid_out,'\n');
end     
% write zigzag data
fprintf(fid_out,'%s\n','DCT Values');
for i=1:1:rowblkN*colblkN
   for j=1:1:dct_block_size*dct_block_size
      fprintf(fid_out,'%s ',num2str(ZZDCTQIm(i,j)));
   end
     fprintf(fid_out,'\n');
end     
status=fclose(fid_out);
dummy=0;

% execute the jpeg entropy program with appropriate output
system(['JPEG_Encoder ' text_filename ' ' jpg_filename]);

[fid, message]=fopen(jpg_filename,'r');
status = fseek(fid,0,'eof');
Len = ftell(fid);
fclose(fid);
