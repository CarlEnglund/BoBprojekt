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


edgeG = edge(G,'canny',0.1);
ave_x_G = sum(edgeG,1)/height; 

edgeR = edge(R,'canny',0.1);
ave_x_R = sum(edgeR,1)/height;

edgeB = edge(B,'canny',0.1);
ave_x_B = sum(edgeB,1)/height;

[val minPosB] = max(ave_x_B((1:width/2)));
[val maxPosB] = max(ave_x_B((round(width/1.5)):width));
[val minPosG] = max(ave_x_G((1:width/2)));
[val maxPosG] = max(ave_x_G((round(width/1.5)):width));
[val minPosR] = max(ave_x_R((1:width/2)));
[val maxPosR] = max(ave_x_R((round(width/1.5)):width));


B = imcrop(B, [minPosR*1.3 minPosR*1.3 maxPosR*0.8+round((width/1.5)) maxPosR*0.8+round((width/1.5))]);
G = imcrop(G, [minPosR*1.3 minPosR*1.3 maxPosR*0.8+round((width/1.5)) maxPosR*0.8+round((width/1.5))]);
R = imcrop(R, [minPosR*1.3 minPosR*1.3 maxPosR*0.8+round((width/1.5)) maxPosR*0.8+round((width/1.5))]);

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