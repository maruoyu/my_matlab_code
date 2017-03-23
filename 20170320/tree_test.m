%% 决策树

clear;
clc;


[NUM, TXT, RAW] = xlsread('缺失数据.xlsx');
[NUM2, TXT2, RAW2] = xlsread('真实数据.xlsx');
[row, column] = size(NUM);
for y = 1 :18
    r = 1;
    for x = 3 : row
        if isnan(NUM(x, y)) == 0 && isnan(NUM(x - 1, y)) == 0 && isnan(NUM(x - 2, y)) == 0
            train(r, :) = [NUM(x-2,y), NUM(x-1,y), NUM(x,y)];
            r = r + 1;
        end
    end
    tree = classregtree(train(:, 1:2), train(:, 3));
    r = 1;
    for x = 3 : row
        if isnan(NUM(x, y)) == 1 && isnan(NUM(x - 1, y)) == 0 && isnan(NUM(x - 2, y)) == 0 && isnan(NUM2(x, y)) == 0
            forecast = eval(tree, NUM(x-2:x-1, y)');
            forecast_data(r, 3 * y - 2 : 3*y) = [forecast, NUM2(x, y), abs( (forecast-NUM2(x, y))/NUM2(x, y) )];
            r = r + 1;
        end
    end
end