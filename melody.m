function mel = melody(filename)
    [orig_sig, fs]=audioread(filename);

    seg_length = fs;
    segments = length(orig_sig)/seg_length;
    num_peaks = 3; % No. of peaks considered in Sinusoid Extraction
    Nh = 8; % No. of Harmonics considered in Salience Function
    segments = 1;
    length_frame = 8192;
    length_hop = 128;
    for ii = 1:segments
        fprintf('Calculating the melody for Segment- %d out of %d segments\n',ii,segments);
        
        % Sinusoid Extract
        start_seg = (ii-1)*seg_length+1;
        end_seg = (ii)*seg_length;      
        [IA,IF] = sinusoid_extract(orig_sig(start_seg:end_seg),fs,num_peaks);
        save("amplitude.mat","IA","IF")
        % Salience Function
        S = salience_func(IA,IF,Nh);
        disp("size(S)");
        save("S.mat",'S');
        % disp(size(S));
        % raw_contour  = pitch_contours(S,seg_length,length_frame,length_hop);
        raw_contour  = pitch_contours(S);
        raw_contour_characteristics = contour_characteristics(raw_contour);
        save("raw_contour.mat",'raw_contour','raw_contour_characteristics');

        % melody_audio = get_audio(melody_contour,seg_length,length_frame,length_hop);
        % disp(S);
    end
end