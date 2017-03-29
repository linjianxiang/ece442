%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Motion Estimation using Exhaustive Search Function Template
% Author : Adam Harrison
%--------------------------------------------------------------------------
function [p,q]=Log_Search(Im_ref,Im_cur,N1,N2,Range)

Im_ref = imread(Im_ref); %load reference image
Im_cur = imread(Im_cur); %load current image
figure(1);
subplot(1,2,1),imshow(Im_ref);
subplot(1,2,2),imshow(Im_cur);
Im_ref=double(Im_ref);
Im_cur=double(Im_cur);

%Find the motion vector using logarithmic search. You may find it beneficial
%to use sub-functions for this portion. This is the biggest task of your
%function.
[row col] = size(Im_cur);
p = zeros(row/N1,col/N2); %Used to store horizantal moving vectors
q = zeros(row/N1,col/N2); %Used to store vertical moving vectors
counter1 = 0;
counter2 = 0;

% Start off from the top left of the image
% For every block, find a minimum MAD value
% store the motion vector into u and v
for m = 1 : N1 : row-N1+1
    counter1 = counter1 +1;
    for n = 1 : N2 : col-N2+1
        counter2 = counter2 +1;
        % three-step search starts
        step = Range;
        u = 0;
        v = 0; 
        while( step>= 2 )
            step = round(step/2);
            MAD = inf;
            for i=-1:1
                for j=-1:1
                    test_x = j*step+u+n;
                    test_y = i*step+v+m;

                    if(test_y<1 || test_y+N1-1>row ...
                            || test_x<1 || test_x+N2-1>col)
                        continue;
                    end
                    %compute the MAD for two blocks
                    MAD_temp = costFuncMAD(Im_cur(m:m+N1-1,n:n+N2-1), ...
                     Im_ref(test_y:test_y+N1-1, test_x:test_x+N2-1), Range);
                 
                    if MAD_temp<MAD
                        MAD = MAD_temp;
                        Temp_v = i*step+v;
                        Temp_u = j*step+u;
                    end
                end
            end
            u = Temp_u;
            v = Temp_v;      
        end
        %Store the motion vectors in u and v. Note you should have a u and v value
        p(counter1, counter2) = v;
        q(counter1, counter2) = u;     
      
    end
    counter2 = 0; %Reset counter2
end

figure(5);
%show the result using quiver
%call quiver with the correct parameters 
[x,y]=meshgrid([1:11],[-1:-1:-9]);
quiver(x,y,p,-q);
title('Motion vector');
end
