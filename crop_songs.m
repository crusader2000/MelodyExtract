filename='../3.mp3';
[y, fs]=audioread(filename);
samples=[(15*fs),(16*fs)];
[y1,fs] = audioread(filename,samples);
audiowrite('3_cut.wav',y1,fs);
