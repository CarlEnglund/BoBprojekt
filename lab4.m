%Carl Englund
%caren083 MT3A
%caren083@student.liu.se

file = '01043v.jpg'; %Three girls

fileending = strsplit(file,'.');
picture = im2double(imread(file));
[height width] = size(picture);
scalevalue = 1;
height = round(height/3);

blueChannel = picture(1:height, :); %Blue
greenChannel = picture(height*1+1:(height*2), :); %Green
redChannel = picture(height*2:(height*3)-1, :); %Red

%Reduce the partial images
if(strcmp(fileending(2), 'tif'))
   for i = 1:3
        blueChannel = imresize(blueChannel, 0.5);
        greenChannel = imresize(greenChannel, 0.5);
        redChannel = imresize(redChannel, 0.5);
        scalevalue =  2.^i;
   end
   [height width] = size(blueChannel);
end


%Retrieve a patch in the middle of the picture and use the Edge method.
blueMiddle = imcrop(blueChannel, [round(width/2.5) round(height/2.5) round((width/2.5)+width*0.05) round((height/2.5)+height*0.05)]);
greenMiddle = imcrop(greenChannel, [round(width/2.5) round(height/2.5) round((width/2.5)+width*0.05) round((height/2.5)+height*0.05)]);
redMiddle = imcrop(redChannel, [round(width/2.5) round(height/2.5) round((width/2.5)+width*0.05) round((height/2.5)+height*0.05)]);

blueMiddle = edge(blueMiddle, 'canny', 0.01);
greenMiddle = edge(greenMiddle, 'canny', 0.01);
redMiddle = edge(redMiddle, 'canny', 0.01);

%Retrieve the correct positions again
displacementB = shifting(blueMiddle, greenMiddle);
displacementR = shifting(redMiddle, greenMiddle);

[height width] = size(picture);
height = round(height/3);

%Shift the channels to their correct positions
RtoG = circshift(picture(height*2:(height*3)-1, :), displacementR*scalevalue);
BtoG = circshift(picture(1:height, :), displacementB*scalevalue);

%Make it into a colorimage
colorImage = cat(3,  RtoG, picture(height*1+1:(height*2), :), BtoG);

%Image operations If you dont want to use the contrast fix just remove  
%the second argument in the matching function. (It checks how many arguments
%that are sent in to the function)
croppedImage = cropping(colorImage);
weightedColors = matching(croppedImage, 1);
imshow(croppedImage);
