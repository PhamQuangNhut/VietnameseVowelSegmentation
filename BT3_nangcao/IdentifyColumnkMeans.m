function vowelColumn = IdentifyColumnkMeans(featureVectors, fv, K)
    distances = [];
    vowelColumn = 1;
    
    for i = 1 : 5*K
        distance = EuclideanDistance(featureVectors, fv(:, i));     
        if distance < min(distances)           
            vowelColumn = i;
        end
        distances = [distances, distance];
    end
end