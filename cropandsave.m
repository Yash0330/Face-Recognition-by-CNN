function  cropandsave(im,str)
j = 1;
T = countEachLabel(im);
n = T(1,2).Variables;
for i = 1:n
    i1 = readimage(im,i);
    [img,face] = cropface(i1);
    if face==1
        imwrite(img,['croppedfaces\', str,'\',int2str(j), '.jpg']);
        j = j+1;
    end
end
