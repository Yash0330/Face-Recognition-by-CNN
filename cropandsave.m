function  cropandsave(im,str,n)
j = 1;
for i = 1:n
    i1 = readimage(im,i);
    [img,face] = cropface(i1);
    if face==1
        imwrite(img,[ str,'\',int2str(j), '.jpg']);
        j = j+1;
    end
end
