function melody_audio = get_audio(melody_contour,seg_length,M,H)
    melody_audio = zeros(1,seg_length);
    num_frames = size(melody_contour,2);
    curr = 1;
    samples = 1:H
    for ii = 1:num_frames
        % amp = melody_contour(ii)  % Get the amplitude
        % freq = melody_contour(ii)  % Get the frequency
        freq_hz = get_hz(freq);
        melody_audio(curr,curr+H) = amp*sin(2*pi*freq_hz*samples) + 0.01*amp*sin(2*pi*3*freq_hz*samples) + 0.0001*amp*sin(2*pi*5*freq_hz*samples);
        curr = curr + H;
    end

    melody_audio(curr,:) = amp*sin(2*pi*freq_hz*samples) + 0.01*amp*sin(2*pi*3*freq_hz*samples) + 0.0001*amp*sin(2*pi*5*freq_hz*samples); % For last samples

end

function hz = get_hz(cents)
    hz = 55*2^(((cents-1)*10)/1200)
end