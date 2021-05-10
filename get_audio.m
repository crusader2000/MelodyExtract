function melody_audio = get_audio(melody_contour_amp,melody_contour_pitch,seg_length,M,H)
    melody_audio = zeros(seg_length,1);
    num_frames = length(melody_contour_amp);
    curr = 1;
    samples = 1:H;
    % disp(num_frames);
    % disp(melody_contour_amp);
    % disp(melody_contour_pitch);
    for ii = 1:num_frames
        amp = melody_contour_amp(ii); % Get the amplitude
        freq = melody_contour_pitch(ii);  % Get the frequency
        freq_hz = get_hz(freq);
        % disp(freq_hz);
        % disp(length(curr:curr+H-1));
        % disp(length(amp*sin(2*pi*freq_hz*samples)));
        melody_audio(curr:curr+H-1) = amp*sin(2*pi*freq_hz*samples) + 0.01*amp*sin(2*pi*3*freq_hz*samples) + 0.0001*amp*sin(2*pi*5*freq_hz*samples);
        curr = curr + H;
    end
    samples = curr:seg_length;
    melody_audio(curr:seg_length) = amp*sin(2*pi*freq_hz*samples) + 0.01*amp*sin(2*pi*3*freq_hz*samples) + 0.0001*amp*sin(2*pi*5*freq_hz*samples); % For last samples
    % disp("melody_audio(1:20)");
    % disp(melody_audio(1:20));
end

function hz = get_hz(cents)
    % disp("((cents-1)*10)/1200");
    % disp(cents);
    % disp(((cents-1)*10)/1200);
    hz = 55*2^(((cents-1)*10)/1200);
end