%Tìm 5 vector đặc trưng
function featureVectorMatrix = FindListFeatureVectorFFT(vowelSet,fileList,frameSample, sampleShift, NFFT)
    featureVectorMatrix = [];
    
    for i = 1 : length(vowelSet)
        featureVectors = 0;
        for j = 1 : length(fileList)
            path = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmHuanLuyen-16k\', fileList(j), '\', vowelSet(i), '.wav');
            [x, ~] = audioread(path);

            x_normal =  x ./ max(abs(x)); 
            numberFrame = floor((length( x_normal) - frameSample)/sampleShift) + 1;

            %Tìm vùng nguyên âm
            [startSpeech, endSpeech] = GetFrameOfVowel(x_normal, frameSample,numberFrame, sampleShift);
            
            % Vùng ổn định của nguyên âm 
            [startStable,endStable] = FindStableRegion(startSpeech,endSpeech);
            
            % Vector đặc trưng cho 1 nguyên âm của 1 người nói
            featureVector = FindFeatureVectorFFT( x_normal,  startStable, endStable,frameSample, sampleShift, NFFT);
            % Tổng vector đặc trưng nhiều người
            featureVectors = featureVectors + featureVector;
        end
        % Vector trung bình 1 nguyên âm nhiều người nói
        featureVectors = featureVectors / length(fileList);
        % Ma trận 5 vector đặc trưng (NFFT hàng, 5 cột)
        featureVectorMatrix = [featureVectorMatrix, featureVectors];           
    end
end
