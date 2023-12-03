%Tìm vector đặc trưng 1 nguyên âm 1 người nói
function featureVector = FindFeatureVectorFFT(x, startStableFrame, endStableFrame, frameSample, sampleShift, NFFT)
    featureVector = 0;
    for i = startStableFrame : endStableFrame
        %giá trị tín hiệu tại khung thứ i
        x_i = x((i-1)*sampleShift : (i-1)*sampleShift + frameSample);
        vectorFFT = abs(fft(x_i, NFFT));
        
        featureVector = featureVector + vectorFFT;
    end
    %Trung bình cộng vector đặc trưng M khung
    featureVector = featureVector / (endStableFrame - startStableFrame + 1);
end
