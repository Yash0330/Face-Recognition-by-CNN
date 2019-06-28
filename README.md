# SimpleFaceRecognition
Face recognition from training pretrained neural network alexnet and using cascade object detector for cropping faces.
Using capturefacesfromvideo.m to get training data from video and saving images of faces. Run this for all subjects.Create folders s01,s02,s03,. for subject photos.
And using cropface.m to crop faces from images from training data.
And training Convolutional Neural Network alexnet by modifying output layesrs by number of subjects.
Using trained newnet for face recognition.
