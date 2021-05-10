filtered_contours = load('filtered_contours.mat').filtered_contours;
max_amp = max(max(cell2mat(filtered_contours(:,3))));
disp("max_amp");
disp(max_amp);
melody_audio = zeros(44100,1);

for ii = 1:length(filtered_contours)
    % for ii = 1:1
    melody_contour_amp = cell2mat(filtered_contours(ii,4))/max_amp;
    melody_contour_pitch = cell2mat(filtered_contours(ii,3));
    % disp(melody_audio(1:20));
    % temp = get_audio(melody_contour_amp,melody_contour_pitch,44100,2048,128);
    melody_audio = melody_audio + get_audio(melody_contour_amp,melody_contour_pitch,44100,2048,128);
    % disp(temp(1:20));
end

% stem(1:44100,melody_audio);

p = audioplayer(melody_audio,44100);
play(p)
