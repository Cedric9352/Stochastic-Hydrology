function xi = normalDSS()
%% Normal distribution sequence simulation
    % input:
    %	s is the season numbers.
    % output:
    %   xi is the normal distribution sequence
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 13th, 2016
 
%% Calculation
y1 = rand;
y2 = rand;
xi = sqrt((-2)*log(y1))*cos(2*pi*y2);

