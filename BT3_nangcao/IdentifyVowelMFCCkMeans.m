function [identifyDataArraykMeans, ConfusionMatrixkMeans] = IdentifyVowelMFCCkMeans(frameSample, N_MFCC, audioList, vowelList, featureListVectorMFCCkMeans,sampleShift, K)
    ConfusionMatrixkMeans = zeros(5, 5);
    identifyDataArraykMeans = cell(0, 3);
    res = 0;
    for i = 1:length(vowelList)
        for j = 1:length(audioList)
            filepath = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmKiemThu-16k\', audioList(j), '\', vowelList(i), '.wav');
            disp(filepath)
            [x, Fs] = audioread(filepath);
            xNorm = x / max(abs(x));
            numberFrame = floor((length(xNorm) - frameSample)/sampleShift) + 1;
            
            [startVowel,endVowel] = GetFrameOfVowel(xNorm,frameSample,numberFrame,sampleShift);

            % Vùng ổn định của nguyên âm (center area)
            [startStable,endStable] = FindStableRegion(startVowel,endVowel);
            
            
            % Tìm vector đặc trưng của một người nói
           featureVector = FindFeatureVectorMFCC(xNorm, Fs, (startStable-1)*sampleShift, endStable*sampleShift + frameSample, N_MFCC);
            
            % Nhận dạng nguyên âm
            vowelColumn = IdentifyColumnkMeans(featureVector, featureListVectorMFCCkMeans, K);
            vowelColumn = ceil(vowelColumn / K);
            % Cập nhật lại giá trị của cột
            ConfusionMatrixkMeans(i, vowelColumn) = ConfusionMatrixkMeans(i, vowelColumn) + 1;
            
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
                res = res + 1;
            else
                tf = 'False';
            end
            
            resultRow = {[char(audioList(j)), '/', char(vowelList(i)), '.wav'], result, tf};
            identifyDataArraykMeans = [identifyDataArraykMeans; resultRow];
        end
    end
    % Đếm số dòng có giá trị 'True'
    countTrue = sum(strcmp(identifyDataArraykMeans(:, 3), 'True'));
    resultRow = {'', '', countTrue};
    identifyDataArraykMeans = [identifyDataArraykMeans; resultRow];
    disp(res);
end
