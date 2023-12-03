%Trả về cột nguyên âm nhận dạng được
function vowelColumn = IdentifyColumn(featureVector, featureVectorMatrix)
    distances = [];
    vowelColumn = 1;
    for col = 1 : 5   %a e i o u
        distance = EuclideanDistance(featureVector, featureVectorMatrix(:, col));   %Tinh khoang cach giua cac vector dac trung
        if distance < min(distances)         
            %Cot nguyen am nhan dang duoc
            vowelColumn = col;
        end
        distances = [distances, distance];
    end
end