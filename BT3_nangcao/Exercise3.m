clear all; 
rng(42); % You can use any number as the seed
% Danh sách file huấn luyện và kiểm thử
trainList = [ "23MTL", "24FTL", "25MLM", "27MCM", "28MVN", "29MHN", "30FTN", ...
                  "32MTP", "33MHP", "34MQP", "35MMQ", "36MAQ", "37MDS", "38MDS", ...
                 "39MTS", "40MHS", "41MVS", "42FQT", "43MNT", "44MTT", "45MDV"];

testList = [ "01MDA", "02FVA", "03MAB", "04MHB", "05MVB", "06FTB", "07FTC", ...
                   "08MLD", "09MPD", "10MSD", "11MVD", "12FTD", "14FHH", "15MMH", ...
                   "16FTH", "17MTH", "18MNK", "19MXK", "20MVK", "21MTL", "22MHL"];
              
% Danh sách các nguyên âm
vowelList = ["a","e","i","o","u"];
 
fs = 16000;                                                    % Tần số lấy mẫu
frameLength = 0.02;                                 % Chiều dài mỗi Frame
frameSample = floor(frameLength*fs);             % Số mẫu mỗi Frame
frameShift = 0.01;
sampleShift = frameShift*fs;
N_MFCC = 13;                                                     
 
% % Tìm vector đặc trưng mỗi nguyên âm của 21 người (trainList)
% featureListVectorMFCC = FindListFeatureVectorMFCC(frameSample, N_MFCC, trainList, vowelList,sampleShift);
% % Plot graph
% figure(1);
% sgtitle('Vector đặc trưng của 5 nguyên âm');
% subplot(5,1,1); plot(featureListVectorMFCC(:, 1)); xlabel('sample'); ylabel(''); title('a');
% subplot(5,1,2); plot(featureListVectorMFCC(:, 2)); xlabel('sample'); ylabel(''); title('e');
% subplot(5,1,3); plot(featureListVectorMFCC(:, 3)); xlabel('sample'); ylabel(''); title('i');
% subplot(5,1,4); plot(featureListVectorMFCC(:, 4)); xlabel('sample'); ylabel(''); title('o');
% subplot(5,1,5); plot(featureListVectorMFCC(:, 5)); xlabel('sample'); ylabel(''); title('u');
% 
% figure(2);
% sgtitle("Vector đặc trưng của 5 nguyên âm trên 1 đồ thị");
% plot(featureListVectorMFCC(:, 1), "LineWidth", 1.3); hold on;
% plot(featureListVectorMFCC(:, 2), "LineWidth", 1.3); hold on;
% plot(featureListVectorMFCC(:, 3), "LineWidth", 1.3); hold on;
% plot(featureListVectorMFCC(:, 4), "LineWidth", 1.3); hold on;
% plot(featureListVectorMFCC(:, 5), "LineWidth", 1.3); hold off;
% legend('a', 'e', 'i', 'o', 'u');
% 
% % Gọi hàm nhận dạng nguyên âm
% [identifyDataArray, ConfusionMatrix] = IdentifyVowelMFCC(frameSample, N_MFCC, testList, vowelList, featureListVectorMFCC,sampleShift);
% 
% % Tạo figure
% f = figure('Name', 'Result detail of identification', 'Position', [400, 100, 500, 400]);
% columnNames = {'Speaker Label', 'Result', 'True/False'};
% t = uitable(f, 'Data', identifyDataArray, 'ColumnName', columnNames, 'Position',  [20 30 460 350]);
% set(t,'ColumnWidth',{120},'ColumnEditable', false)
% 
% 
% figure(4);
% sgtitle("Confusion matrix");
% % Tạo ma trận nhầm lẫn
% class = {'a'; 'e'; 'i'; 'o'; 'u'};
% ConfusionMatr = confusionchart(ConfusionMatrix, class, 'RowSummary','row-normalized');
% 
K = 4;
featureListVectorMFCCkMeans = FindListFeatureVectorMFCCkMeans(frameSample, N_MFCC, trainList, vowelList,sampleShift, K);
[identifyDataArraykMeans, ConfusionMatrixkMeans] = IdentifyVowelMFCCkMeans(frameSample, N_MFCC, testList, vowelList, featureListVectorMFCCkMeans,sampleShift, K);
figure(1);
sgtitle("Confusion matrix with K-Means");
% Tạo ma trận nhầm lẫn
class = {'a'; 'e'; 'i'; 'o'; 'u'};
ConfusionMatrkMeans = confusionchart(ConfusionMatrixkMeans, class, 'RowSummary','row-normalized');