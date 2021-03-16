S = load('S.mat').S;

IA = load('amplitude.mat').IA;
IF = load('amplitude.mat').IF;

% Nh = 5;
% S = salience_func(IA,IF,Nh);


% Salience Peaks per frames
N = 3367 % Num frames
% To handle NaN
S(S>=0 == 0) = 0;
mean_all = mean(mean(S));

tau_plus = mean_all/10; %first stage threshold

% First Stage 
disp("cutoff1");
disp(tau_plus);
loc_filtered = (S >= tau_plus);
[row,col] = find(loc_filtered); % row and col contains the locations of non zero indinces of loc_filtered

peaks_out = loc_filtered.*S;

% Second Stage
mean_s = mean(S(loc_filtered));
std_s = std(S(loc_filtered));

tau_sigma = 0.05;
cutoff2 = mean_s - tau_sigma*std_s;
disp("cutoff2");
disp(cutoff2);
loc_filtered2 = (peaks_out >= cutoff2);
peaks_out2 = loc_filtered2.*S;

S_plus = loc_filtered2.*1;
S_minus = (S>0).*1 - S_plus;
contourf(S_plus);
figure;
contourf(S_minus);
