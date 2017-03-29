% BR_Q_mpg.m
% Bit rate and Quality trade-off in MPEG-1
%
% Capstone Multimedia Lab
% Department of Electrical and Computer Engineering
% University of Maryland, College Park
% This m file calls read_im_seq.m, write_im_seq.m, file_size and PSNR_seq.m.
% 
% Author: Guan-Ming Su - modified by Adam Harrison for ECE442 Lab4
% 
%***************************************************
% in_filename: format is set of images WITHOUT the extension and number
% suffixes, ie 'fm' for foreman
% mgp_filename: is the desired filename of the mpeg you would like to
% save WITH the extension .mpg
% range: positive integer specifying search range. 
% Q_i: An integer between 1 and 31.  
% Q_p: An integer between 1 and 31. 
% Q_b: An integer between 1 and 31.  
%***************************************************
function BR_Q_mpg(in_filename,mpg_filename,Range,Q_i,Q_p,Q_b)

close all;

%%%%%% parameters
frameN=10;

out_filename=[in_filename '_mpl'];

fmt='tif';
mpg_option=[1, 0, 1, 0,  Range,  Q_i,  Q_p,  Q_b];
Nframepersecond=30;



% read a image sequence
M=read_im_seq(in_filename,fmt,frameN);
map=colormap;


mpgwrite(M,map,mpg_filename,mpg_option);

% read the mpeg file
[nM]=mpgread(mpg_filename,1:frameN,'truecolor');
f_size=file_size(mpg_filename);
bitrate=8*f_size/(frameN/Nframepersecond);
Kbps=bitrate/1000;

% write out the image sequence
% Due to some bug in the movie object, the 2nd frame is the same with 1st, 
% we shift the image frame by minus 1
write_im_seq(nM,frameN,out_filename,fmt);

figure(1)
% calculate PSNR
PSNR=PSNR_seq(in_filename,fmt,out_filename,fmt,frameN-1);
avePSNR=mean(PSNR)
bitrate
Kbps
plot(1:frameN-1,PSNR);
title(strcat(' Bitrate:',num2str(bitrate),' average PSNR:',num2str(avePSNR)));