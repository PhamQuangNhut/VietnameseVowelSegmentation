

% Find MFCC of 1 vowel of 1 person
function featureVectorMFCC = FindFeatureVectorMFCC(x_norm, Fs, startStableFrame, endStableFrame, N_MFCC)
    % Thêm đường dẫn tới thư viện
    addpath('D:\University\Semester5\XuLyTinHieuSo\voicebox');

    % Gọi hàm v_melcepst
    MelCepstrum = v_melcepst(x_norm(startStableFrame : endStableFrame), Fs, 'M', N_MFCC, floor(3 * log(Fs)));

    % Xóa đường dẫn đã thêm sau khi sử dụng 
    rmpath('D:\University\Semester5\XuLyTinHieuSo\voicebox');

    % Tính trung bình của MelCepstrum
    featureVectorMFCC = mean(MelCepstrum);
end
