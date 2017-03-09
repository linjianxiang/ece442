function [rowN, colN, dct_block_size, iQ, iZZDCTQIm]=JPEG_entropy_decode(decoder_path,text_filename,jpg_filename)

% function [rowN, colN, dct_block_size, iQ, iZZDCTQIm]=JPEG_entropy_decode(decoder_path)
% JPEG Entropy Decoder
% Input:
%      decoder_path: string: the absolute path where this .m and JPEG_Decoder reside
%      jpeg_entropy_encode.exe exist and also JPEG.jpg and JPEG_DCTQ_ZZ.txt
% Output:
%      rowN: scalar : number of rows in JPEG.jpg
%      colN: scalar : number of columns in JPEG.jpg
%      dct_block_size: scalar: the dimension of square DCT blocks
%      iQ: dct_block_size x dct_block_size : quantization table
%      iZZDCTQIm: (rowN*colN/dct_block_size^2)x(dct_block_size^2) : the zigzagged quantized matrix
%
% Author: Guan-Ming Su
% Date: 8/1/02
% Significant modifications by Emil Wyrod
% Date: 2013-03-09

% execute the jpeg entropy program
if decoder_path(end)~='\' && decoder_path(end)~= '/'
    decoder_path=[decoder_path '/'];
end

if (nargin==1)
   jpg_filename='JPEG.jpg';
   text_filename='JPEG_iDCTQ_ZZ.txt';
end
text_filename=strcat(decoder_path,text_filename);
jpg_filename=strcat(decoder_path,jpg_filename);

system(['JPEG_decoder ' jpg_filename ' ' text_filename]);


% open decoded file by jpeg_entropy_decode
[fid_in,message]=fopen(text_filename,'r');
temp=fgets(fid_in);  % read header
temp=fgetl(fid_in);   temp=fgetl(fid_in); rowN = str2num(temp);   % read number of rows
temp=fgetl(fid_in);   temp=fgetl(fid_in); colN = str2num(temp);   % read number of cols
temp=fgetl(fid_in);   temp=fgetl(fid_in); dct_block_size = str2num(temp);  % read dct block size
temp=fgetl(fid_in);   temp=fgetl(fid_in); % skip over chrominance data
rowblkN = rowN/dct_block_size; colblkN = colN/dct_block_size;

temp=fgetl(fid_in);   % read QT
iQ=zeros(dct_block_size, dct_block_size);  % read table
for i=1:1:dct_block_size
    temp=fgetl(fid_in);
    iQ(i,:)=str2num(temp);
end

temp=fgetl(fid_in);   % read DCT Values
% read data
iZZDCTQIm = zeros(rowblkN*colblkN, dct_block_size*dct_block_size);
for i=1:1:rowblkN*colblkN
   temp=fgetl(fid_in);
   iZZDCTQIm(i,:)=str2num(temp);
end     
fclose(fid_in);
