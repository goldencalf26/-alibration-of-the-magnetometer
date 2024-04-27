function Bm = extractMagnetometerReadings(data)
k = 0;
n = 1;
Bm = [];
while n <= length(data)
    if k == 0
        if data(n) == 170
            k = 1;
        end
        n = n + 1;
    else
        if data(n) == 170
            k = 2;
            if n <= length(data) - 8
                magn = data(n-1:n+8);
                if data(n+7) == 255 & data(n+8) == 255
                    magn = typecast(data(n+1:n+6), 'int16');
                    Bm = double([Bm; magn]); % Сырые показания с магнитометра
                    n = n+9;
                    k = 0;
                else
                    k = 0;
                    n = n + 1;
                end
            else
                break
            end
        else
            k = 0;
            n = n + 1;
        end
    end
end
Bm(1481,:) = []; % Удаление последней строки
end