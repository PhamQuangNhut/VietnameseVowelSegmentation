clear all;
    [x, ~] = audioread('C:\Users\ACER\Documents\Signals_Processing_Digital\Bai_tap_nhom\NguyenAmHuanLuyen-16k\23MTL\e.wav');
    fs = 16000;
    frameLength = 0.03;                                     
    frameShift=0.02;
    sampleShift =floor(frameShift*fs); 
    frameSample = floor(frameLength * fs);         
    
    x_normal = x ./ max(abs(x));
    numberFrame = floor((length(x_normal) - frameSample) / sampleShift) + 1;
    %Tính frame bắt đầu nguyên âm
    [startVowel, endVowel] = GetFrameOfVowel(x_normal,frameSample,numberFrame,sampleShift);
    
    %Thời gian đoạn nguyên âm
    ts_vowel= ((startVowel-1)*sampleShift)/fs;
    te_vowel = ((endVowel-1)*sampleShift+frameSample)/fs;
    
    %Tìm vùng ổn định
    [startStable,endStable] = FindStableRegion(startVowel,endVowel);
    ts_stable= ((startStable-1)*sampleShift)/fs;
    te_stable = ((endStable-1)*sampleShift+frameSample)/fs;
    
    
    t = (1:length(x_normal)) / fs;
    subplot(3,1,1);
    plot(t,x_normal);
    hold on
    plot([ts_vowel,ts_vowel], [min(x_normal), max(x_normal)], '-r', 'LineWidth', 1.2);
    plot([te_vowel,te_vowel], [min(x_normal), max(x_normal)] , '-r', 'LineWidth', 1.2);
    hold off
    xlabel('Thời gian (s)');
    ylabel('Biên độ');
    title('Đoạn nguyên âm(a)');
    
    %Plot the original audio signal with stable
    subplot(3,1,2);
    plot(t,x_normal);
    hold on
    plot([ts_vowel,ts_vowel], [min(x_normal), max(x_normal)], '-r', 'LineWidth', 1.2);
    plot([te_vowel,te_vowel], [min(x_normal), max(x_normal)] , '-r', 'LineWidth', 1.2);
    plot([ts_stable,ts_stable], [min(x_normal), max(x_normal)], '--g', 'LineWidth', 1.2);
    plot([te_stable,te_stable], [min(x_normal), max(x_normal)] , '--g', 'LineWidth', 1.2);
    hold off
    xlabel('Thời gian (s)');
    ylabel('Biên độ');
    title('Đoạn nguyên âm và vùng ổn định(a)');