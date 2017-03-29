
%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Motion Compensation Function Template
% Author : Adam Harrison
% If it suits you, you may keep this function's layout, which accepts block
% size, N1,N2 as parameters.
%--------------------------------------------------------------------------
function [Im_est Residual total_MAD]=Motion_Compensation(u,v,Im_ref1,Im_cur1,N1,N2)

Im_ref=imread(Im_ref1);
Im_cur=imread(Im_cur1);
counter1 = 0; %Use for indexing the row value
counter2 = 0; %Use for indexing the column value

%Compute estimated image based on motion vectors u and v. Store result in
%Im_est. This is the biggest task of your function.
[row col] = size(Im_ref);
for i = 1:N1:row-N1+1
    counter1 = counter1 +1;
    for j = 1:N2:col-N2+1        
        counter2 = counter2 +1;        
        dy = u(counter1,counter2);
        dx = v(counter1,counter2);        
        BlkVertical = i + dy;
        BlkHorizontal = j + dx;
        
        Im_est(i:i+N1-1,j:j+N2-1) = Im_ref(BlkVertical:BlkVertical+N1-1, BlkHorizontal:BlkHorizontal+N2-1);
    end
    counter2 = 0;
end

%Compute the residual, cast operands to double to allow negative numbers
Residual=double(Im_cur)-double(Im_est);

%Cast estimated image to uint8 for display purposes  
Im_est=uint8(Im_est);
figure(3);
imshow(Im_est);title('Reconstructed Image');
imwrite(Im_est,'Reconstructed_Image.jpg');
figure(4);
imshow(Residual,[]);title('Residual Image');
%reformate the Residual matrix inorder to store a more identifiable
%residual image
Residual_reformat = Residual - min(min(Residual));
Residual_reformat = uint8(Residual_reformat);
imwrite(uint8(Residual_reformat),'Residual.jpg');
%Compute the MAD between Im_est and Im_cur        
%total_MAD= %(use the appropriate equation here)
total_MAD = sum(abs(Residual(:)))/(row*col)