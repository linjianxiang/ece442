%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Motion Estimation using Exhaustive Search Function Template
% Author : Adam Harrison
% If it suits you, you may keep this function's layout, which accepts block
% size, N1,N2,and the search range, R, as parameters.
%--------------------------------------------------------------------------
function [u,v]=Exhaustive_Search(Im_ref,Im_cur,N1,N2,Range)
Im_ref= imread(Im_ref);
Im_cur= imread(Im_cur);
close all
figure(1);
subplot(1,2,1),imshow(Im_ref);
subplot(1,2,2),imshow(Im_cur);
Im_ref=double(Im_ref);
Im_cur=double(Im_cur);

%Find the motion vector using exhaustive search. You may find it beneficial
%to use sub-functions for this portion. This is the biggest task of your
%function.
[row col] = size(Im_cur);
u = zeros(row/N1,col/N2);
v = zeros(row/N1,col/N2);
counter1 = 0;
counter2 = 0;
min_value = 999999; % Give a very large initial value

% The searching starts at the top left corner of the image
for i = 1 : N1 : row-N1+1
    counter1 = counter1 +1;
    for j = 1 : N2 : col-N2+1
        counter2 = counter2 +1;
        for k = -Range : Range        
            for t = -Range : Range
                Blk_ref_Ver = i + k;   % row/Vert co-ordinate for ref block
                Blk_ref_Hor = j + t;   % col/Horizontal co-ordinate
                if ( Blk_ref_Ver < 1 || Blk_ref_Ver+N1-1 > row ...
                        || Blk_ref_Hor < 1 || Blk_ref_Hor+N2-1 > col)
                    continue;
                end
                temp = costFuncMAD(Im_cur(i:i+N1-1,j:j+N2-1), ...
                     Im_ref(Blk_ref_Ver:Blk_ref_Ver+N1-1, Blk_ref_Hor:Blk_ref_Hor+N2-1), Range);                
                if(temp<min_value)
                    min_value = temp;
                    temp_k = k;
                    temp_t = t;
                end
            end
        end
        
        %Store the motion vectors in u and v. 
        %for each sub-block, ie, if you have (rows/N1, columns/N2) sub-blocks, you
        %will have the same number of u and v values

        u(counter1, counter2) = temp_k;
        v(counter1, counter2) = temp_t;
        min_value = 100000; % Give a very large initial value
        
    end
    counter2 = 0;
end

figure(2);
%show the result using quiver
%call quiver with the very block
[x,y]=meshgrid([1:11],[-1:-1:-9]);
quiver(x,y,u,-v);
title('Motion vector');
end
