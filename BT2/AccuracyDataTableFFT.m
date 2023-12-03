%Dữ liệu độ chính xác tổng hợp
function data = AccuracyDataTableFFT(testSet, trainSet,vowelSet, frameSample, sampleShift)  
NFFT_values = [512, 1024, 2048];
for k = 1:length(NFFT_values)
    NFFT = NFFT_values(k);
    featureVectorList = FindListFeatureVectorFFT( vowelSet,trainSet,frameSample,  sampleShift, NFFT);
    [~,ConfusionMatrix] =IdentifyVowel(vowelSet, testSet, frameSample,sampleShift, featureVectorList, NFFT);
    data{k, 1} =ConfusionMatrix(1,1);
    data{k, 2} =ConfusionMatrix(2,2);
    data{k, 3} =ConfusionMatrix(3,3);
    data{k, 4} =ConfusionMatrix(4,4);
    data{k, 5} =ConfusionMatrix(5,5);
    data{k, 6} = ConfusionMatrix(1,1)+ConfusionMatrix(2,2)+ConfusionMatrix(3,3)+ConfusionMatrix(4,4)+ConfusionMatrix(5,5);
    data{k, 7} =(ConfusionMatrix(1,1)+ConfusionMatrix(2,2)+ConfusionMatrix(3,3)+ConfusionMatrix(4,4)+ConfusionMatrix(5,5))*100/105;
end
end