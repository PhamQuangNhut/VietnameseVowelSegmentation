%Trả về vị trí bắt đầu và kết thúc frame nguyên âm
function [startVowel,endVowel] = GetFrameOfVowel(signal, frameSample, numberFrame, step)
    ste  = zeros(1, numberFrame);  
    %Phân khung tính giá trị năng lượng
    s_sample = 1; e_sample = frameSample;     %Số mẫu của frame
    for i = 1 : numberFrame  %Số frame 
        ste(i) = sum(signal(s_sample:e_sample).^2);
        s_sample = s_sample + step - (s_sample == 1);
        e_sample = e_sample + step;
    end
    
    ste = ste ./max(abs(ste));
    T = ThresholdSTE(ste);
    %So sánh với ngưỡng tìm vị trí frame của nguyên âm
      for i = 1 : length(ste)
        if ste(i) >= T      %So sánh với ngưỡng
            startVowel = i;
            break;
        end
      end

    for i = startVowel : length(ste)
        if ste(i) < T
            endVowel = i;
            break;
        end
    end
end