% n is the number of subjects
n = 3;
% looping through all subjects and cropping faces if found
% extract the subject photo and crop faces and saving it in to respective
% folders
for i =1:n
    str = ['s0',int2str(i)];
    ds1 = imageDatastore(['photos\',str],'IncludeSubfolders',true,'LabelSource','foldernames');
    cropandsave(ds1,str);
end
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
% Test a new Image
% use code below with giving path to your new image
% img = imread('...\img.jpg');
% img = imresize(img,[227 227]);
% predict = classify(newnet,img)
% and the value of predict determines the output	 
% can use [predict,score] = classify(newnet,img) here score says the percentage that how confidence it is
