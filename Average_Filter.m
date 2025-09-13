clc
clear all
close all
load('dataset2')
gx = dataset2(:,1);
gy = dataset2(:,2);
gz = dataset2(:,3);
ax = dataset2(:,4);
ay = dataset2(:,5);
az = dataset2(:,6);
time = dataset2(:,7);

%% Offset Claculation
sum_gx = 0; sum_gy = 0; sum_gz = 0;
for i =1:50
    sum_gx = sum_gx + gx(i);
    sum_gy = sum_gy + gy(i);
    sum_gz = sum_gz + gz(i);
end

offset_gx = sum_gx/50;
offset_gy = sum_gy/50;
offset_gz = sum_gz/50;

for i = 1:length(gx)
    gx(i) = (gx(i) - offset_gx)*pi/180;
    gy(i) = (gy(i) - offset_gy)*pi/180;
    gz(i) = (gz(i) - offset_gz)*pi/180;
end

figure
hold on
plot(time, gx)

%% Average Filter Algorithm
% k = 1;
% pre_gx_avg = gx(1);
% for i = 1:length(gx)
%     alpha =(k - 1) / k;
%     gx_avg(i) = alpha*pre_gx_avg+(1-alpha)*gx(i);
%     pre_gx_avg = gx_avg(i);
%     k = k + 1;
% end
% figure
% hold on
% plot(time, gx)
% plot(time, gx_avg)
% legend('law', 'avg filtering')
% 
% %%이동 평균 필터 알고리즘
% n = 10;
% xbuf = gx(1)*ones(n+1, 1);
% prevAvg = gx(1);
% for i=1:length(gx)
%     for m=1:n
%         xbuf(m) = xbuf(m+1);
%     end
%     xbuf(n+1) =gx(i);
%     moving_avg(i) = prevAvg + (gx(i) - xbuf(1)) / n;
%     prevAvg = moving_avg(i);
% end


%% Moving Average Filter (n=20)
% n = 20;
% xbuf = gx(1) * ones(n + 1, 1);
% prevAvg = gx(1);
% moving_avg_20 = zeros(length(gx), 1); % 결과 저장용 배열
% for i = 1:length(gx)
%     for m = 1:n
%         xbuf(m) = xbuf(m + 1);
%     end
%     xbuf(n + 1) = gx(i);
%     moving_avg_20(i) = prevAvg + (gx(i) - xbuf(1)) / n;
%     prevAvg = moving_avg_20(i);
% end
% 
% %% 이동 평균 필터 (n=40)
% n = 40;
% xbuf = gx(1) * ones(n + 1, 1);
% prevAvg = gx(1);
% moving_avg_40 = zeros(length(gx), 1); % 결과 저장용 배열
% for i = 1:length(gx)
%     for m = 1:n
%         xbuf(m) = xbuf(m + 1);
%     end
%     xbuf(n + 1) = gx(i);
%     moving_avg_40(i) = prevAvg + (gx(i) - xbuf(1)) / n;
%     prevAvg = moving_avg_40(i);
% end
% 
%% Output
% figure
% hold on
% plot(time, gx)
% plot(time, moving_avg_20, 'r-', 'LineWidth', 1.5) % 이동 평균 (n=20)
% plot(time, moving_avg_40, 'b-', 'LineWidth', 1.5) % 이동 평균 (n=40)
% legend('law','Moving Avg (n=20)', 'Moving Avg (n=40)')
% xlabel('Time (s)')
% ylabel('gx')
% title('Comparison of Moving Average Filters (n=20 vs n=40)')
% grid on
% hold off

% Low Pass Filter Algorithm
alpha = 0.3;
pre_lpf_gx = 0;
for i = 1:length(gx)
    lpf_gx(i) = alpha*pre_lpf_gx + (1-alpha)*gx(i);
    pre_lpf_gx = lpf_gx(i);
end

alpha2 = 0.9;
pre_lpf_gx2 = 0;
for i=1:length(gx)
    lpf_gx2(i) = alpha2 * pre_lpf_gx2 + (1-alpha2)*gx(i);
    pre_lpf_gx2 = lpf_gx2(i);
end

figure
hold on
plot(time, gx)
plot(time, lpf_gx, 'r-', 'LineWidth', 1.5); % alpha = 0.3 Filter
plot(time, lpf_gx2, 'b--', 'LineWidth', 1.5); % alpha = 0.9 Filter
legend('law','Low-Pass Filter (α = 0.3)', 'Low-Pass Filter (α = 0.9)');
xlabel('Time (s)');
ylabel('Filtered gx');
title('Comparison of Low-Pass Filters with Different α Values');
grid on;
hold off;
