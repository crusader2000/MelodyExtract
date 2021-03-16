function mel = melody(filename)
    [orig_sig, fs]=audioread(filename);

    seg_length = 2*fs;
    segments = length(orig_sig)/seg_length;
    num_peaks = 1; % No. of peaks considered in Sinusoid Extraction
    Nh = 5; % No. of Harmonics considered in Salience Function
    
    segments = 1;
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
        disp(size(S));
        % disp(S);
    end
end