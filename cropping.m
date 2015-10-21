%Carl Englund
%caren083 MT3A
%caren083@student.liu.se

function [croppedImage] = cropping(unCroppedImage)

%Check the beginning of the image for cropping in x and y. Then use the
%same distance on the other side.. Not the smartest or best of crops
%im afraid

[height width d] = size(unCroppedImage);

edgeImage = edge((rgb2gray(unCroppedImage)),'canny', 0.01);

ave_x = sum(edgeImage,1)/width; 
ave_y = sum(edgeImage,2)/height; 
xCrop = round(find(ave_x(1:end*0.1)>mean(ave_x), 5, 'last'));
yCrop = round(find(ave_y(1:end*0.1)>mean(ave_y), 5, 'last'));
   
xCrop = max(xCrop);
yCrop = max(yCrop);

%Some extra padding since the cropping seems to work better with it.
padding = ceil(height/100);

croppedImage = imcrop(unCroppedImage, [xCrop yCrop+padding width-2*xCrop height-2*yCrop-padding]);

end