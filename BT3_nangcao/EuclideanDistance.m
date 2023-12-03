function distance = EuclideanDistance(a, b)
    s = 0;
    for i = 1: length(a)
        s = s + (b(i) - a(i)).^2;
    end
    distance = sqrt(s);
end