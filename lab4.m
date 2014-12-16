clear

tic

file = '00106a.tif';

fileending = strsplit(file,'.');
tic
picture = im2double(imread(file));
toc
[height width] = size(picture);

if(strcmp(fileending(2), 'tif'))
    threshold = 100;
    percent = 0.1;
else
    threshold = 20;
    percent = 1;
end

height = round(height/3);

B = picture(1:height, :);
G = picture(height*1+1:(height*2), :);
R = picture(height*2:(height*3)-1, :);

Btest = imcrop(B, [round(width/2) round(width/2) round((width/2)*percent) round((width/2)*percent)]);
Gtest = imcrop(G, [round(width/2) round(width/2) round((width/2)*percent) round((width/2)*percent)]);
Rtest = imcrop(R, [round(width/2) round(width/2) round((width/2)*percent) round((width/2)*percent)]);

Btest = edge(Btest, 'canny');
Gtest = edge(Gtest, 'canny');
Rtest = edge(Rtest, 'canny');

displacementB = shifting(Btest, Gtest, threshold);
displacementR = shifting(Rtest, Gtest, threshold);

RtoG = circshift(R, displacementR);
BtoG = circshift(B, displacementB);
   
colorImage = cat(3,  RtoG, G, BtoG);

toc