clear all;close all; clc;

testSet = [ "01MDA", "02FVA", "03MAB", "04MHB", "05MVB", "06FTB", "07FTC", "08MLD", "09MPD", "10MSD", "11MVD", "12FTD", "14FHH", "15MMH", "16FTH", "17MTH", "18MNK", "19MXK", "20MVK", "21MTL", "22MHL"];
trainSet = [ "23MTL", "24FTL", "25MLM", "27MCM", "28MVN", "29MHN", "30FTN", "32MTP", "33MHP", "34MQP", "35MMQ", "36MAQ", "37MDS", "38MDS",  "39MTS", "40MHS", "41MVS", "42FQT", "43MNT", "44MTT", "45MDV"];
              
vowelSet = ["a","e","i","o","u"];
 
fs = 16000;
frameLength = 0.03;                                          
frameShift =0.02;                     % Khoảng dịch khung
sampleShift = floor(frameShift * fs);         % Số mẫu chuyển sang frame khác
frameSample = floor(frameLength * fs);          % Số mẫu của mỗi frame
NFFT = 2048;                                                %  512, 1024, 2048

% Tìm vector đặc trưng của 5 nguyên âm
featureVectorMatrix = FindListFeatureVectorFFT(vowelSet, trainSet, frameSample, sampleShift, NFFT);

%5 vector đặc trừng trên 1 đồ thị
figure(1);
sgtitle("Vector đặc trưng phổ 5 nguyên âm trên 1 đồ thị");
hold on;
plot(featureVectorMatrix(:, 1),'LineWidth', 0.5); 
plot(featureVectorMatrix(:, 2),'LineWidth', 0.5); 
plot(featureVectorMatrix(:, 3),'LineWidth', 0.5); 
plot(featureVectorMatrix(:, 4), 'LineWidth', 0.5); 
plot(featureVectorMatrix(:, 5),'LineWidth', 0.5); 
hold off;
legend('a', 'e', 'i', 'o', 'u');

% Tìm kết quả nhận dạng từng file và ma trận nhầm lẫn
 [identifyDataArray, ConfusionMatrix] = IdentifyVowel(vowelSet, testSet, frameSample,sampleShift, featureVectorMatrix, NFFT);

% Xuất kết quả nhận dạng từng file
f1 = figure('Name', 'Kết quả nhận dạng từng file', 'Position', [400, 100, 500, 400]);
columnNames = {'Speaker Label', 'Result', 'True/False'};
t1 = uitable(f1, 'Data', identifyDataArray, 'ColumnName', columnNames, 'Position',  [20 30 460 350]);
set(t1,'ColumnWidth',{120},'ColumnEditable', false)

% Vẽ bảng thống kê độ chính xác
data = AccuracyDataTableFFT(testSet, trainSet,vowelSet,frameSample, sampleShift);
f2 = figure('Position',[400 400 560 120]);
cnames = {'a','e','i','o','u','File','Accuracy(%)'};
rnames = {'NFFT=512','NFFT=1024','NFFT=2048'};
t2 = uitable('Parent',f2,'Data',data,'ColumnName',cnames,'RowName',rnames,'Position',[20 30 550 80]);
set(t2);

%Bảng ma trận nhầm lẫn
figure(4);
sgtitle("Ma trận nhầm lẫn");
class = {'a'; 'e'; 'i'; 'o'; 'u'};
confusionChart = confusionchart(ConfusionMatrix, class, 'RowSummary','row-normalized');





