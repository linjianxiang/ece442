function [blm] = show_bit_image(image,bit_plane)
k = ceil(bit_plane^0.5);
for i = 1:bit_plane;
    subplot(k,k,i);
    blm = bitget(image,i);
    imshow(blm,[]); title(strcat(num2str(i),'bit plane'));
end
end