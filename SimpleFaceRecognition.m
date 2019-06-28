ds1 = imageDatastore('C:\Users\yash\Documents\photos\SimpleFaceRecognition*.jpg');
for i = 1:929
   i1 = readimage(ds1,i);
   [img,face] = cropface(i1);
   if face==1
       imwrite(img,[ 'C:\Users\yash\Documents\croppedfaces',int2str(j), '.jpg']);
       j = j+1;
   end
end
 ds = imageDatastore('C:\Users\yash\Documents\photos\SimpleFaceRecognition\croppedfaces*.jpg');
 im = imageDatastore('croppedfaces','IncludeSubfolders',true,'LabelSource','foldernames');
 names = im.Labels;
 fc = fullyConnectedLayer(1);
 net = alexnet;
 ly = net.Layers;
 ly(23) = fc;
 cl = classificationLayer;
 ly(25) = cl; 
 opts = trainingOptions("sgdm","InitialLearnRate",0.0001,'Plots','training-progress');
 im.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
 [newnet,info] = trainNetwork(im, ly, opts);
 [predict,scores] = classify(newnet,testimg);
  
  
  
  
  
  