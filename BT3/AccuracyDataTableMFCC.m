function data = AccuracyDataTableMFCC(testList,trainList,vowelList,N_MFCC,frameSample, sampleShift)
featureListVectorMFCC = FindListFeatureVectorMFCC(frameSample, N_MFCC, trainList, vowelList,sampleShift);
[~,Confusion_Matrix] = IdentifyVowelMFCC(frameSample, N_MFCC, testList, vowelList, featureListVectorMFCC,sampleShift);

    data{1,1} = Confusion_Matrix(1,1);
    data{1,2} = Confusion_Matrix(2,2);
    data{1,3} = Confusion_Matrix(3,3);
    data{1,4} = Confusion_Matrix(4,4);
    data{1,5} = Confusion_Matrix(5,5);
    data{1,6} = Confusion_Matrix(1,1) + Confusion_Matrix(2,2) + Confusion_Matrix(3,3) + Confusion_Matrix(4,4) + Confusion_Matrix(5,5);
    data{1,7} = (Confusion_Matrix(1,1) + Confusion_Matrix(2,2) + Confusion_Matrix(3,3) + Confusion_Matrix(4,4) + Confusion_Matrix(5,5))*100/105;
