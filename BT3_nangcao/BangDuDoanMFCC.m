clear all;

% Danh sách file huấn luyện và kiểm thử
trainList = ["23MTL", "24FTL", "25MLM", "27MCM", "28MVN", "29MHN", "30FTN", ...
    "32MTP", "33MHP", "34MQP", "35MMQ", "36MAQ", "37MDS", "38MDS", ...
    "39MTS", "40MHS", "41MVS", "42FQT", "43MNT", "44MTT", "45MDV"];

testList = ["01MDA", "02FVA", "03MAB", "04MHB", "05MVB", "06FTB", "07FTC", ...
    "08MLD", "09MPD", "10MSD", "11MVD", "12FTD", "14FHH", "15MMH", ...
    "16FTH", "17MTH", "18MNK", "19MXK", "20MVK", "21MTL", "22MHL"];

% Dánh sách các nguyên âm
vowelList = ["a", "e", "i", "o", "u"];

fs = 16000;                                                    % Tần số lấy mẫu
frameLength = 0.03;                                 % Chiều dài mỗi Frame
frameSample = floor(frameLength*fs);             % Số mẫu mỗi Frame
frameShift = 0.02;
sampleShift = frameShift*fs;
N_MFCC = 13;    

% Vẽ ma trận
f = figure('Position', [400 400 600 140]);
featureListVectorMFCC = FindListFeatureVectorMFCC(frameSample, N_MFCC, trainList, vowelList,sampleShift);
[~,Confusion_Matrix] = IdentifyVowelMFCC(frameSample, N_MFCC, testList, vowelList, featureListVectorMFCC,sampleShift);

    data{1,1} = Confusion_Matrix(1,1);
    data{1,2} = Confusion_Matrix(2,2);
    data{1,3} = Confusion_Matrix(3,3);
    data{1,4} = Confusion_Matrix(4,4);
    data{1,5} = Confusion_Matrix(5,5);
    data{1,6} = Confusion_Matrix(1,1) + Confusion_Matrix(2,2) + Confusion_Matrix(3,3) + Confusion_Matrix(4,4) + Confusion_Matrix(5,5);
    data{1,7} = (Confusion_Matrix(1,1) + Confusion_Matrix(2,2) + Confusion_Matrix(3,3) + Confusion_Matrix(4,4) + Confusion_Matrix(5,5))*100/105;

cnames = {'a', 'e', 'i', 'o', 'u', 'Sum_file','Accuracy(%)'};
rnames = {'N_MFCC = 13'};
t = uitable('Parent', f, 'Data', data, 'ColumnName', cnames, 'RowName', rnames, 'Position', [20 35 555 60]);
set(t);
