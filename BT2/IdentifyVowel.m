%Trả về dữ liệu nhận dạng từng file và ma trận nhầm lẫn
    function [identifyDataArray, ConfusionMatrix] = IdentifyVowel(vowelSet, fileList, frameSample,sampleShift,featureVectorMatrix,NFFT)
    ConfusionMatrix = zeros(5, 5); 

    %Dữ liệu nhận dạng từng file
    identifyDataArray = cell(0, 3);

    for i = 1:length(vowelSet)
        for j = 1:length(fileList)
            filepath = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmKiemThu-16k\', fileList(j), '\', vowelSet(i), '.wav');
            [x, ~] = audioread(filepath);

            x_normal = x /max(abs(x));
            numberFrame = floor((length(x_normal) - frameSample) / sampleShift) + 1;
            % Tìm đoạn nguyên âm    
            [startSpeech, endSpeech] = GetFrameOfVowel(x_normal, frameSample,numberFrame, sampleShift);

            % Tìm vùng ổn định
            [startStable,endStable] = FindStableRegion(startSpeech,endSpeech);

            % Vector đặc trưng 1 nguyên âm 1 người
            featureVector = FindFeatureVectorFFT(x_normal, startStable, endStable, frameSample,sampleShift, NFFT);

            % Nhận dạng cột
            VowelColumn = IdentifyColumn(featureVector, featureVectorMatrix);

            % Cập nhật dữ liệu
            ConfusionMatrix(i, VowelColumn) = ConfusionMatrix(i, VowelColumn) + 1;


           % Dữ liệu bảng chi tiết nhận dạng
            switch VowelColumn
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

          if(strcmp(vowelSet(i), result))
            tf = 'True';
          else
            tf = 'False';
          end

            resultRow = {[char(fileList(j)), '/', char(vowelSet(i)),'.wav'], result, tf};
            identifyDataArray = [identifyDataArray; resultRow];
        end
    end

% Đếm số dòng nhận dạng đúng
countTrue = sum(strcmp(identifyDataArray(:, 3), 'True'));
resultRow = {'', '',countTrue};
identifyDataArray = [identifyDataArray; resultRow];
end