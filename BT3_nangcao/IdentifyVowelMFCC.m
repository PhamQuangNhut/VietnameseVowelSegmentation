function [identifyDataArray, ConfusionMatrix] = IdentifyVowelMFCC(frameSample, N_MFCC, audioList, vowelList, featureListVectorMFCC,sampleShift)
    ConfusionMatrix = zeros(5, 5);
    identifyDataArray = cell(0, 3);
    
    for i = 1:length(vowelList)
        for j = 1:length(audioList)
            filepath = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmKiemThu-16k\', audioList(j), '\', vowelList(i), '.wav');
            [x, Fs] = audioread(filepath);
            
            % Chuẩn hóa x về [-1;1]
            xNorm = x / max(abs(x));
            numberFrame = floor(length(xNorm) / frameSample);
            
            % Chuẩn hóa x về [-1;1]
            % xNorm = x / max(abs(x));
            numberFrame = floor((length(xNorm) - frameSample)/sampleShift) + 1;
            [startVowel,endVowel] = GetFrameOfVowel(xNorm,frameSample,numberFrame,sampleShift);

            % Vùng ổn định của nguyên âm (center area)
            [startStable,endStable] = FindStableRegion(startVowel,endVowel);
            
             
            % Vector đặc trưng cho 1 nguyên âm của 1 người nói
            featureVector = FindFeatureVectorMFCC(xNorm, Fs, (startStable-1)*sampleShift, endStable*sampleShift + frameSample, N_MFCC);
            
            % Nhận dạng nguyên âm
            vowelColumn = IdentifyColumn(featureVector, featureListVectorMFCC);
            
            % Cập nhật lại giá trị của cột
            ConfusionMatrix(i, vowelColumn) = ConfusionMatrix(i, vowelColumn) + 1;
            
            % Dữ liệu chi tiết của bảng nhận dạng
            switch vowelColumn
                case 1
                    result = 'a';
                case 2
                    result = 'e';
                case 3
                    result = 'i';
                case 4
                    result = 'o';
                case 5
                    result = 'u';
            end
            
            if strcmp(vowelList(i), result)
                tf = 'True';
            else
                tf = 'False';
            end
            
            resultRow = {[char(audioList(j)), '/', char(vowelList(i)), '.wav'], result, tf};
            identifyDataArray = [identifyDataArray; resultRow];
        end
    end
    
    % Đếm số dòng có giá trị 'True'
    countTrue = sum(strcmp(identifyDataArray(:, 3), 'True'));
    resultRow = {'', '', countTrue};
    identifyDataArray = [identifyDataArray; resultRow];
end
