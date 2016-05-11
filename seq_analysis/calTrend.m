function calTrend(t)
%% calculation of trend of sequence
    % input:
    %   t is a the original sequence
    %   five-point-average method
    % output:
    %   graph of trend
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: April 19th, 2016

%% initialization
y = zeros(1,size(t,2));
sum_t = zeros(1,size(t,2));

%% calculation
for i = 1:size(t,2)
    if(i < 3)
        for k = 1:i+2
            sum_t(i) = sum_t(i) + t(k);
        end
        y(i) = sum_t(i) / (i+2);
    elseif(i > size(t,2)-2)
        for k = i-2:size(t,2)
            sum_t(i) = sum_t(i) + t(k);
        end
        y(i) = sum_t(i) / (size(t,2)-i+3);
    else
        for k = i-2:i+2
            sum_t(i) = sum_t(i) + t(k);
        end
        y(i) = sum_t(i) / 5;
    end
end
%% plot
title('calculation of trend')
xlabel('t');
ylabel('yt');
plot(1970:1:2004,y,'r-');
hold on;
plot(1970:1:2004,t,'b-');
legend('five-point-average method','raw sequence');
