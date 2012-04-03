function IMF=myemf(old_time, points,iterations)

% initialise
close all
% Calculate dicrete time points and apply cubic interpolation
t = (min(old_time)+0.1):1/100:(max(old_time)-0.1);
x = interp1(old_time, points, t, 'cubic');

% Peak algorthm accuracy
paa = 25;

for iter=1:iterations
%Start plotting
figure('name','IMF calculation')
subplot(3,1,1);

%Find local maxima
[locs,pks] = peakfinder(x,(max(x)-min(x))/paa,[],1);
max_x = interp1(t(locs),x(locs),t,'cubic');
plot(t,max_x, 'r')
hold on

% Find local minima
[locs,pks] = peakfinder(x,(max(x)-min(x))/paa,[],-1);
min_x = interp1(t(locs),x(locs),t,'cubic');
plot(t,min_x, 'g')

% Find average
avg_x = (max_x+min_x)/2;
plot(t,avg_x, 'k')

% Plot graph
plot(t,x)
title 'Original data'
hold off

% new subplot and find first IMF
subplot(3,1,2);
IMF(iter,:) = x - avg_x;
plot(t,IMF(iter,:))
title 'IMF'

subplot(3,1,3);
new_data = x - IMF(iter,:);
plot(t,new_data)
title 'New Data'
x = new_data;
end
return
