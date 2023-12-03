% Find Feature Vector MFCC of 1 vowel of all person

function fvList = FindListFeatureVectorMFCCkMeans(frameSample, N_MFCC, audioList, vowelList, sampleShift ,K)
    fvList = [];
    
     % Đọc 5 nguyên âm của file huấn luyện
    for i = 1 : length(vowelList)
        featureList = {};
        featureVectors = 0;
        for j = 1 : length(audioList)
            filepath = strcat('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmHuanLuyen-16k\', audioList(j), '\', vowelList(i), '.wav');
            [x, Fs] = audioread(filepath);
            
            % Chuẩn hóa x về [-1;1]
            xNorm = x / max(abs(x));
             numberFrame = floor((length(xNorm) - frameSample)/sampleShift) + 1;
            [startVowel,endVowel] = GetFrameOfVowel(xNorm,frameSample,numberFrame,sampleShift);

            % Vùng ổn định của nguyên âm (center area)
            [startStable,endStable] = FindStableRegion(startVowel,endVowel);
            
            % Vector đặc trưng cho 1 nguyên âm của 1 người nói
            featureVector = FindFeatureVectorMFCC(xNorm, Fs, (startStable-1)*sampleShift, (endStable-1)*sampleShift + frameSample, N_MFCC);
            featureList{end+1} = featureVector;
            %featureVectors = featureVectors + featureVector;
        end
        % Vector đặc trưng cho 1 nguyên âm của nhiều người nói
        num_vectors = length(featureList);
        vector_length = length(featureList{1}); % Giả sử độ dài của mỗi feature vector là như nhau
        feature_matrix = zeros(num_vectors, vector_length);
        
        for i = 1:num_vectors
            feature_matrix(i, :) = featureList{i};
        end
        
        % Số lượng cụm K bạn muốn tạo
        
        % Áp dụng thuật toán K-Means lên ma trận feature vectors
        [idx, centroids] = kmeans(feature_matrix, K);
        
        % Tạo một list kết quả có K phần tử, mỗi phần tử trong list là một danh sách chứa feature vectors của từng cụm
        resultList = cell(1, K);
        
        for i = 1:K
            cluster_indices = find(idx == i); % Lấy chỉ số các feature vectors thuộc cụm i
            resultList{i} = feature_matrix(cluster_indices, :); % Lưu các feature vectors vào list kết quả
            mean_vector = mean(resultList{i}, 1);
            fvList = [fvList, mean_vector(:)];   
        end
        % featureVector audioList
        % featureVectors = featureVectors / length(audioList);
        % List of 5 featureVector (Each column is featureVector of 1 vowel) -> size: (MFCC) rows, 5 columns
        % fvList = [fvList, mean_vector(:)];           
    end
end

