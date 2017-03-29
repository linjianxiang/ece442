%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Motion Estimation using Exhaustive Search Function Template
% Author : Adam Harrison
% If it suits you, you may keep this function's layout, which accepts block
% size, N1,N2,and the search range, R, as parameters.
%--------------------------------------------------------------------------
function [u,v]=Exhaustive_Search2(Im_ref,Im_cur,N1,N2,Range)
close all
figure;
% N1 = 16;
% N2 = 16;
% Range = 16;
% Im_ref = imread('carphone0195.tif');
% Im_cur = imread('carphone0196.tif');
subplot(1,2,1),imshow(Im_ref);
subplot(1,2,2),imshow(Im_cur);
Im_ref=double(Im_ref);
Im_cur=double(Im_cur);
[row,col] = size(Im_ref);
u = zeros(row,col);
v = zeros(row,col);
u_2 = zeros(row/N1,col/N2);
v_2 = zeros(row/N1,col/N2);
%Find the motion vector using exhaustive search. You may find it beneficial
%to use sub-functions for this portion. This is the biggest task of your
%function.
for i = 0:N1:(row-N1)
    for j = 0:N2:(col-N2)
        
        block_cur = Im_cur(i+1:i+N1,j+1:j+N2);

        if (i==0) && (j==0)
           row_search_start = 0;
           row_search_end = N1;
           col_search_start = 0;
           col_search_end = N2;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref+1:j_ref+N2);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                    u_2((i/16)+1,(j/16)+1) = i_ref-i;
                    v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                    u_2((i/16)+1,(j/16)+1) = i_ref-i;
                    v_2((i/16)+1,(j/16)+1) = j_ref-j;

                end
            end
           end   
        elseif (i==(row-N1) && j==(col-N2))
           row_search_start = i-N1;
           row_search_end = row;
           col_search_start = j-N2;
           col_search_end = col;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref-Range+1:i_ref,j_ref-Range+1:j_ref);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
       elseif (i==0) && (j==(col-N2))
           row_search_start = 0;
           row_search_end = N1;
           col_search_start = j-Range;
           col_search_end = col;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref-Range+1:j_ref);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;      
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;          
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        elseif (i==(row-N1) && (j==0))
           row_search_start = i-Range;
           row_search_end = row-N1;
           col_search_start = 0;
           col_search_end = N2;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref+1:j_ref+N2);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;      
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;        
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        elseif (i==0) 
           row_search_start = 0;
           row_search_end = N1;
           col_search_start = j-Range;
           col_search_end = j+N2-1;
           for i_ref =  row_search_start:row_search_end
             for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+Range,j_ref+1:j_ref+Range);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        elseif (j==0) 
           row_search_start = i-Range;
           row_search_end = i+Range-1;
           col_search_start = 0;
           col_search_end = N2;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
%                 if (i_ref+N1) == 144
%                     2
%                 end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref+1:j_ref+N2);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        elseif (i == row - N1) 
           row_search_start = i-Range;
           row_search_end = row-N1;
           col_search_start = j-Range;
           col_search_end = j+Range-1;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref+1:j_ref+N2);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                     u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                     v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        elseif (j == col - N2) 
           row_search_start = i-Range;
           row_search_end = i+N1;
           col_search_start = j - Range;
           col_search_end = col;
           for i_ref =  row_search_start:row_search_end
            for j_ref = col_search_start:col_search_end
                compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref-N2+1:j_ref);
                if (i_ref == row_search_start) && (j_ref == col_search_start)
                    error_min = sum((compare_block-block_cur).^2);
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
                error = sum((compare_block-block_cur).^2);
                if(error<error_min)
                    error_min = error;
                    u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                    v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                end
            end
           end     
        else
            row_search_start = i-Range;
            row_search_end = i+Range;
            col_search_start = j-Range;
            col_search_end = j+Range;
            for i_ref =  row_search_start:row_search_end
                for j_ref = col_search_start:col_search_end
                    compare_block = Im_ref(i_ref+1:i_ref+N1,j_ref+1:j_ref+N2);
                    if (i_ref == row_search_start) && (j_ref == col_search_start)
                        error_min = sum((compare_block-block_cur).^2);
                        u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                        v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;
                    end
                    error = sum((compare_block-block_cur).^2);
                    if(error<error_min)
                        error_min = error;
                        u(i+1:i+N1,j+1:j+N2) = i_ref-i;
                        v(i+1:i+N1,j+1:j+N2) = j_ref-j;
                        u_2((i/16)+1,(j/16)+1) = i_ref-i;
                        v_2((i/16)+1,(j/16)+1) = j_ref-j;

                    end
                end
            end
        end
        
    end
end




%Store the motion vectors in u and v. Note you should have a u and v value
%for each sub-block, ie, if you have (rows/N1, columns/N2) sub-blocks, you
%will have the same number of u and v values


% figure;
% [x,y] = meshgrid(1:16:col,1:16:row);
% %quiver(x,y,u_2,v_2);
% quiver(u_2,v_2);
end
%show the result using quiver
%call quiver with the correct parameters 


        
        
        