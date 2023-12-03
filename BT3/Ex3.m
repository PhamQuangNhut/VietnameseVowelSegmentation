clear all; 
rng(42); % You can use any number as the seed
% Danh sách file huấn luyện và kiểm thử
trainSet = [ "23MTL", "24FTL", "25MLM", "27MCM", "28MVN", "29MHN", "30FTN", ...
                  "32MTP", "33MHP", "34MQP", "35MMQ", "36MAQ", "37MDS", "38MDS", ...
                 "39MTS", "40MHS", "41MVS", "42FQT", "43MNT", "44MTT", "45MDV"];

testSet = [ "01MDA", "02FVA", "03MAB", "04MHB", "05MVB", "06FTB", "07FTC", ...
                   "08MLD", "09MPD", "10MSD", "11MVD", "12FTD", "14FHH", "15MMH", ...
                   "16FTH", "17MTH", "18MNK", "19MXK", "20MVK", "21MTL", "22MHL"];
              
% Danh sách các nguyên âm
vowelSet = ["a","e","i","o","u"];
 
fs = 16000;                                                    % Tần số lấy mẫu
frameLength = 0.025;                                 % Chiều dài mỗi Frame
frameSample = floor(frameLength*fs);             % Số mẫu mỗi Frame
frameShift = 0.01;
sampleShift = frameShift*fs;
N_MFCC = 13;                                                     
 
% Tìm vector đặc trưng mỗi nguyên âm của 21 người (trainList)
featureListVectorMFCC = FindListFeatureVectorMFCC(frameSample, N_MFCC, trainSet, vowelSet,sampleShift);
% file_name = 'C:\Users\ACER\Documents\Signals_Processing_Digital\Bai_tap_nhom\SourceCode\DuLieuVectorMFCC.txt';
% file_id = fopen(file_name, 'w');
% if file_id == -1
%     error('Không thể mở file để ghi.');
% end
% for i=1:5
%  fprintf(file_id, '%0.3f  ', featureListVectorMFCC(:, i));
%  fprintf(file_id,"\n");
% end
% fclose(file_id);

%Vẽ đồ thị
figure(1);
sgtitle("Vector đặc trưng phổ 5 nguyên âm trên 1 đồ thị");
plot(featureListVectorMFCC(:, 1), "LineWidth", 2); hold on;
plot(featureListVectorMFCC(:, 2), "LineWidth", 2); hold on;
plot(featureListVectorMFCC(:, 3), "LineWidth", 2); hold on;
plot(featureListVectorMFCC(:, 4), "LineWidth", 2); hold on;
plot(featureListVectorMFCC(:, 5), "LineWidth", 2); hold off;
legend('a', 'e', 'i', 'o', 'u');

% Gọi hàm nhận dạng nguyên âm
[identifyDataArray, ConfusionMatrix] = IdentifyVowelMFCC(frameSample, N_MFCC, testSet, vowelSet, featureListVectorMFCC,sampleShift)

%Tạo bảng nhận dạng từng file
f = figure('Name', 'Kết quả nhận dạng từng file', 'Position', [400, 100, 500, 400]);
columnNames = {'Speaker Label', 'Result', 'True/False'};
t = uitable(f, 'Data', identifyDataArray, 'ColumnName', columnNames, 'Position',  [20 30 460 350]);
set(t,'ColumnWidth',{120},'ColumnEditable', false)

%Tạo ma trận nhầm lẫn
figure(3);
sgtitle("Prediction vowel");
class = {'a'; 'e'; 'i'; 'o'; 'u'};
ConfusionMatr = confusionchart(ConfusionMatrix, class, 'RowSummary','row-normalized');

%Vẽ bảng thống kê
f = figure('Name', 'Bảng thống kê','Position', [400 400 600 140]);
data = AccuracyDataTableMFCC(testSet,trainSet,vowelSet,N_MFCC,frameSample, sampleShift);
cnames = {'a', 'e', 'i', 'o', 'u', 'Sum_file','Accuracy(%)'};
rnames = {'N_MFCC = 13'};
t = uitable('Parent', f, 'Data', data, 'ColumnName', cnames, 'RowName', rnames, 'Position', [20 35 555 60]);
set(t);
 