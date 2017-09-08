%Holly Ross
%September 8, 2017
%Assigment 01
%Plotting the progress of an ant in a maze

close all; clear all; clc;

 StartingFrame = 1;
 EndingFrame = 448;
 
 Xcentroid = [];
 Ycentroid = [];
 
 
 for k = StartingFrame : EndingFrame - 1
     
    pos1 = imread(['ant/img' sprintf('%2.3d',k),'.jpg']);
    pos2 = imread(['ant/img' sprintf('%2.3d',k + 1),'.jpg']);

    pos1gray = rgb2gray(pos1);
    pos2gray = rgb2gray(pos2);
    
    diff1 = abs(pos1gray - pos2gray);

    imhist(diff1);

    diff1Thresh = diff1 > 5;


    SE = strel('disk',5,0);
    BW = imopen(diff1Thresh, SE);
    BW2 = imclose(BW, SE);

    [labels, number] = bwlabel(BW2,8);
    
    if number > 0
        Istats = regionprops(labels, 'basic', 'Centroid');
        [maxVal, maxIndex] = max([Istats.Area]); 
    
    Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
    Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
    end
 
     
 end
 
  imshow(pos2);
  hold on;
  plot(Xcentroid, Ycentroid);
  
 




