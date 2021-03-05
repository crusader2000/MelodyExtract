%%%%%%%%%%%%
% Frequency/Amplitude Correction:
%%%%%%%%%%%%
% Frequency points = 2049

spect_intensity = load('intensity.mat').spect_intensity;
spect_phase = load('intensity.mat').spect_phase;

% Local Maxima - K
% Spectral peaks - P
[P,K] = max(spect_intensity);

% Instantaneous Frequency - IF
IF = zeros(size(P));
% Instantaneous Amplitude - IA
IA = zeros(size(P));

num_frames = size(P,2);

N = size(spect_intensity,1);
H = 128;
fs = 44100;

w  = window(@hann,N);


for ii = 1:num_frames
    if ii == 1
        IF(ii) = (K(ii) + bin_offset(spect_phase(K(ii),ii),0,K(ii),N,H))*(fs/N);
        IA(ii) = P(ii)/(2*w(mod(N+round(bin_offset(spect_phase(K(ii),ii),0,K(ii),N,H)),N)));
    else
        IF(ii) = (K(ii) + bin_offset(spect_phase(K(ii),ii),spect_phase(K(ii),ii-1),K(ii),N,H))*(fs/N);
        IA(ii) = P(ii)/(2*w(mod(N+round(bin_offset(spect_phase(K(ii),ii),spect_phase(K(ii),ii-1),K(ii),N,H)),N)));
    end
end
