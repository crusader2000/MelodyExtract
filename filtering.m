
close all;
clear all;
clc;

filename='3_cut.wav';
linewidth=2;	% width of lines to plot in graphs
[orig_sig, fs]=audioread(filename);
fprintf("fs = %d\n",fs);

%%%%%%%%%%%%
% Filtering
%%%%%%%%%%%%
EL80=[0,120;20,113;30,103;40,97;50,93;60,91;70,89;80,87;90,86;100,85;200,78;300,76;400,76;500,76;600,76;700,77;800,78;900,79.5;1000,80;1500,79;2000,77;2500,74;3000,71.5;3700,70;4000,70.5;5000,74;6000,79;7000,84;8000,86;9000,86;10000,85;12000,95;15000,110;20000,125;fs/2,140];


% Convert target frequency and amplitude data into format suitable for yulewalk function
f=EL80(:,1)./(fs/2);
m=10.^((70-EL80(:,2))/20);

% Design a 10 coefficient filter using "yulewalk" function
[By,Ay]=yulewalk(10,f,m);
iterm_sig=filter(By,Ay,orig_sig);

% Design a 2nd order Butterwork high-pass filter using "butter" function
[Bb,Ab]=butter(2,(150/(fs/2)),'high');

filt_sig=filter(Bb,Ab,iterm_sig);


fprintf("Length of audio signal - %d\n",length(orig_sig));
fprintf("Length of filtered signal - %d\n",length(filt_sig));

% a = fft(orig_sig);
% e = fft(filt_sig);

% plot(1:length(a),a(:,1),1:length(e),e(:,1));
% figure;
% stem(1:length(a),fftshift(abs(fft(a(:,1)))));
% hold on;
% stem(1:length(e),fftshift(abs(fft(e(:,1)))));
% figure;
% plot(1:length(a),a(:,2),1:length(e),e(:,2));
% figure;
% stem(1:length(a),fftshift(abs(a(:,2))));
% hold on;
% stem(1:length(e),fftshift(abs(e(:,2))));

% p = audioplayer(filt_sig, fs);
% play(p)

audiowrite('filtered_sig.wav',filt_sig,fs);


%%%%%%%%%%%%
% Get the  STFT
%%%%%%%%%%%%
spectrum = mirspectrum('filtered_sig.wav','Frame',0.1857596,0.0029,'ZeroPad',4,'Window','hann');
spect_intensity = get(spectrum,'Magnitude');
spect_phase = get(spectrum,'Phase');
spect_intensity = spect_intensity{1}{1};
spect_phase = spect_phase{1}{1};

save('intensity.mat','spect_intensity','spect_phase');
