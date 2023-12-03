
function fvList = FindListFeatureVectorMFCC(frameSample, N_MFCC, fileList, vowelSet, sampleShift)
    fvList = [];
    
     % Đọc 5 nguyên âm của file huấn luyện
    for i = 1 : length(vowelSet)
        featureVectors = 0;
        for j = 1 : length(fileList)
            filepath = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmHuanLuyen-16k\', fileList(j), '\', vowelSet(i), '.wav');
            [x, Fs] = audioread(filepath);
            
            % Chuẩn hóa x về [-1;1]
            xNorm = x / max(abs(x));
            numberFrame = floor((length(xNorm) - frameSample)/sampleShift) + 1;
            [startVowel,endVowel] = GetFrameOfVowel(xNorm,frameSample,numberFrame,sampleShift);

            % Vùng ổn định của nguyên âm (center area)
            [startStable,endStable] = FindStableRegion(startVowel,endVowel);
            
            % Vector đặc trưng cho 1 nguyên âm của 1 người nói
            featureVector = FindFeatureVectorMFCC(xNorm, Fs, (startStable-1)*sampleShift, (endStable-1)*sampleShift + frameSample, N_MFCC);
            featureVectors = featureVectors + featureVector;
        end
        % Vector đặc trưng cho 1 nguyên âm của nhiều người nói
        featureVectors = featureVectors / length(fileList);
        % Danh sách 5 vecto đặc trưng 
        fvList = [fvList, featureVectors(:)];           
    end
end

