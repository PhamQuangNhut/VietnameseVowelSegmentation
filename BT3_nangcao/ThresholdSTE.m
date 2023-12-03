function threshold = ThresholdSTE(steFrames)
    factor = 0.1;
    % Tính độ biến động của STE
    rangeSTE = max(steFrames) - min(steFrames);
    % Chọn ngưỡng dựa trên độ biến động
    threshold = 0.5;
end