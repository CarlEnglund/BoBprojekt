clear
tic

file = '01788v.jpg';
fileending = strsplit(file,'.');
tic
picture = im2double(imread(file));
toc
[height width] = size(picture);
scalevalue = 1;

height = round(height/3);

B = picture(1:height, :);
G = picture(height*1+1:(height*2), :);
R = picture(height*2:(height*3)-1, :);

if(strcmp(fileending(2), 'tif'))
   for i = 1:3
        B = imresize(B, 0.5);
        G = imresize(G, 0.5);
        R = imresize(R, 0.5);
        scalevalue =  2.^i;
   end
   [height width] = size(B);
end

Btest = imcrop(B, [round(width/2.5) round(height/2.5) round((width/2.5)+width/10) round((height/2.5)+height/10)]);
Gtest = imcrop(G, [round(width/2.5) round(height/2.5) round((width/2.5)+width/10) round((height/2.5)+height/10)]);
Rtest = imcrop(R, [round(width/2.5) round(height/2.5) round((width/2.5)+width/10) round((height/2.5)+height/10)]);

Btest = edge(B, 'canny', 0.01);
Gtest = edge(G, 'canny', 0.01);
Rtest = edge(R, 'canny', 0.01);

displacementB = shifting(Btest, Gtest);
displacementR = shifting(Rtest, Gtest);

RtoG = circshift(picture(height*2:(height*3)-1, :), displacementR*scalevalue);
BtoG = circshift(picture(1:height, :), displacementB*scalevalue);

colorImage = cat(3,  RtoG, picture(height*1+1:(height*2), :), BtoG);

colorImage = cropping(colorImage);
colorImage2 = matching(colorImage);
toc