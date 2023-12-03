function [] = function_draw1(input)
    arr = ['a','e','i','o','u'];
    for i = 1:5
        audioName = fullfile('D:\University\Semester5\XuLyTinHieuSo\signals\NguyenAmHuanLuyen-16k', input, [arr(i) '.wav']);
        [x,Fs] = audioread(audioName);
        % Định nghĩa cửa sổ và trùng lặp cho spectrogram
        %window_length = round(20e-3 * Fs); % 20 ms window length
        %overlap = round(10e-3 * Fs); % 10 ms overlap
        window_length = round(5e-3 * Fs); % 5ms window length
        overlap = round(2.5e-3  * Fs); % 2.5 ms overlap
        nfft = 1024; % số lượng FFT điểm 
        % Vẽ spectrogram
        subplot(5, 1, i);
        spectrogram(x, window_length, overlap, nfft, Fs, 'yaxis');
        title(["Wideband spectrogram of vowel /" + arr(i) + "/ by " + input]);
      
    end
   
end
