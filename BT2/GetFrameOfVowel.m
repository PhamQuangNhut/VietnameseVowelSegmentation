%Trả về vị trí bắt đầu và kết thúc frame nguyên âm
function [startVowel,endVowel] = GetFrameOfVowel(signal, frameSample, numberFrame, sampleShift)
    ste  = zeros(1, numberFrame);  
    %Phân khung tính giá trị năng lượng
    s_sample = 1; e_sample = frameSample;     %Số mẫu của mỗi frame
    for i = 1 : numberFrame  
        ste(i) = sum(signal(s_sample:e_sample).^2);
        s_sample = s_sample + sampleShift - (s_sample == 1);
        e_sample = e_sample + sampleShift;
    end
    
     ste = ste ./max(abs(ste));
     T = 0.5;
    %So sánh với ngưỡng tìm vị trí frame của nguyên âm
      for i = 1 : length(ste)
        if ste(i) >= T   
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