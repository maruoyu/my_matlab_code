%% 线性划框

clear;
clc;


[NUM, TXT, RAW] = xlsread('缺失数据.xlsx');
[NUM2, TXT2, RAW2] = xlsread('真实数据.xlsx');
[row, column] = size(NUM);
for y = 1:18
    r = 1;
    for x = 1:row
        if isnan(NUM(x, y)) == 1 && isnan(NUM2(x, y)) == 0
            for m = 9:-1:0
                number = 1;
                data = zeros(1, 2);
                for n = 0:9
                    if x -m + n > 0 && x -m + n < row + 1
                        if isnan(NUM(x - m + n, y)) == 0
                            data(number, :) = [x - m + n, NUM(x - m + n, y)];
                            number = number + 1;
                        end
                    end
                end
                %fit = polyfit(data(:, 1)', data(:, 2)', 1);
                %forecast(10 - m) = fit(1) * x + fit(2);
                fit = polyfit(data(:, 1)', data(:, 2)', 2);
                forecast(10 - m) = fit(1) * x^2 + fit(2) * x + fit(3);
            end
            forecast_data(r, 3 * y - 2 : 3*y) = [sum(forecast)/10, NUM2(x, y), abs( ((sum(forecast)/10)-NUM2(x, y))/NUM2(x, y) )];
            r = r + 1;
        end
    end
end
