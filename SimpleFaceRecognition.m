% n is the number of subjects
n = 3;
% looping through all subjects and cropping faces if found
% extract the subject photo and crop faces and saving it in to respective
% folders
% numofs01,numofs02,numofs03,....,etc is the number of the images of subject 1, subject 2, subject 3,...,etc.
numofs01 = 1000;
numofs02 = 990;
numofs03 = 980;
ds1 = imageDatastore('...\s01\img*.jpg');
ds2 = imageDatastore('...\s02\img*.jpg');
ds3 = imageDatastore('...\s03\img*.jpg');
cropandsave(ds1,'s01',numofs01);
cropandsave(ds2,'s02',numofs02);
cropandsave(ds3,'s03',numofs03);
 im = imageDatastore('croppedfaces','IncludeSubfolders',true,'LabelSource','foldernames');
 % Resize the images to the input size of the net
 im.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
 [Train ,Test] = splitEachLabel(im,0.8,'randomized');
 fc = fullyConnectedLayer(n);
 net = alexnet;
 ly = net.Layers;
 ly(23) = fc;
 cl = classificationLayer;
 ly(25) = cl; 
 % options for training the net if your newnet performance is low decrease
 % the learning_rate
 learning_rate = 0.0001;
 opts = trainingOptions("sgdm","InitialLearnRate",learning_rate,'Plots','training-progress');
 [newnet,info] = trainNetwork(Train, ly, opts);
 % To test a new image first save it and cropface using cropface.m([img,face] = cropface(img); and if it returned 1 for face then save it and resize
 % using img = imresize(img,[227 227]) and use predict = classify(newnet,img) and the value of predict determines the output
 % can use [predict,score] = classify(newnet,img) here score says the percentage that how confidence it is.
 [predict,scores] = classify(newnet,Test);
 names = Test.Labels;
 pred = (predict==Test);
 s = size(pred);
 acc = sum(pred)/s(1);
 fprintf('The accuracy of the test set is %f \n',acc);
  
  
  
  
  
  
