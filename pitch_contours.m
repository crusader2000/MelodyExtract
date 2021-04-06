function final_contour = pitch_contours(S)
    % function final_contour = pitch_contours(S,length_segment,length_frame,length_hop)
    % length_segment = 44100;
    % length_frame = 8192; % fs*46.4ms
    % length_hop = 128;
    % Salience Peaks per frames

   % Salience Peaks per frames
    N = size(S,2) % Num frames
    num_bins = size(S,1) % Num bins
    % To handle NaN
    S(S>=0 == 0) = 0;
    mean_all = mean(mean(S));

    tau_plus = 10*mean_all; %first stage threshold

    % First Stage 
    disp("cutoff1");
    disp(tau_plus);
    loc_filtered = (S >= tau_plus);
    [row,col] = find(loc_filtered); % row and col contains the locations of non zero indinces of loc_filtered

    peaks_out = loc_filtered.*S;

    % Second Stage
    mean_s = mean(S(loc_filtered));
    std_s = std(S(loc_filtered));

    % tau_sigma = 0;
    tau_sigma = 0.001;
    cutoff2 = mean_s - tau_sigma*std_s;
    disp("cutoff2");
    disp(cutoff2);
    loc_filtered2 = (peaks_out >= cutoff2);
    peaks_out2 = loc_filtered2.*S;

    S_plus_loc = loc_filtered2.*1;  
    S_minus_loc = (S>0).*1 - S_plus_loc;

    S_plus = S.*S_plus_loc;
    S_minus = S.*S_minus_loc;

    close all;
    % contour(S_plus);
    % colorbar;
    % xlabel("Frame Number");
    % ylabel("Frequency(bins)");
    % title("S plus")
    % figure;
    % contour(S_minus);
    % colorbar;
    % xlabel("Frame Number");
    % ylabel("Frequency(bins)");
    % title("S minus")

    % Select the highest peak in S+
    % Find a peak in the next frame in the 8 bins around the previous peak

    final_contour = cell(50,4);
    count = 1;

    while max(max(S_plus)) ~= -1
    % for unknown = 1:40
        [S1,I1] = max(S_plus);
        [S2,I2] = max(S1);
        % fprintf("S2 - %d\n",S2);
        % fprintf("(I1(I2),I2) - (%d,%d)\n ",I1(I2),I2);
        % disp(S(I1(I2),I2));
    
        start_bin = I1(I2);
        start_frame = I2;
        salience_contour = [S_plus(I1(I2),I2)];
        pitch_contour = [start_bin];
        S_plus(I1(I2),I2) = -1;
        curr_frame = start_frame+1;
        curr_bin = start_bin;
        % fprintf("count - %d start_frame - %d\n",count,start_frame);
        contour_start = start_frame;
        contour_end = start_frame;
        
        gap_length = 0;
        while curr_frame <= N
            if gap_length > 5
                break
            end
            no_val = true;
            found = false;
            for ii = 0:8
                bin_ut = curr_bin - ii;
                try 
                    if S_plus(bin_ut,curr_frame) > 0
                        salience_contour = [salience_contour;S_plus(bin_ut,curr_frame)];
                        pitch_contour = [pitch_contour;curr_bin];
                        S_plus(bin_ut,curr_frame) = -1;
                        curr_bin = bin_ut;
                        gap_length = 0;
                        found = true;
                        no_val = false;
                        break 
                    end
                    bin_ut = curr_bin + ii;
                    if S_plus(bin_ut,curr_frame) > 0
                        salience_contour = [salience_contour;S_plus(bin_ut,curr_frame)];
                        pitch_contour = [pitch_contour;curr_bin];
                        S_plus(bin_ut,curr_frame) = -1;
                        curr_bin = bin_ut;
                        gap_length = 0;
                        found = true;
                        no_val = false;
                        break 
                    end
                end
            end
            if ~found
                for ii = 0:8
                    bin_ut = curr_bin - ii;
                    try 
                        if S_minus(bin_ut,curr_frame) > 0
                            salience_contour = [salience_contour;S_minus(bin_ut,curr_frame)];
                            pitch_contour = [pitch_contour;curr_bin];
                            S_minus(bin_ut,curr_frame) = -1;
                            curr_bin = bin_ut;
                            gap_length = gap_length + 1;
                            no_val = false;
                            break 
                        end
                        
                        bin_ut = curr_bin + ii;
                        if S_minus(bin_ut,curr_frame) > 0
                            salience_contour = [salience_contour;S_minus(bin_ut,curr_frame)];
                            pitch_contour = [pitch_contour;curr_bin];
                            S_minus(bin_ut,curr_frame) = -1;
                            curr_bin = bin_ut;
                            gap_length = gap_length + 1;
                            no_val = false;
                            break 
                        end
                    end
                end
            end
                % disp(S(bin_ut,curr_frame+1));
            if no_val
                break;
            end
            curr_frame = curr_frame + 1;
        end
        
        contour_end = curr_frame-1;  
        if curr_frame == (N+1)
            contour_end = N;
        end

        curr_frame = start_frame-1;
        curr_bin = start_bin;
        gap_length = 0;
        while curr_frame > 0
            if gap_length > 5
                break
            end
            no_val = true;
            found = false;
            for ii = 0:8
                bin_ut = curr_bin - ii;
                try
                    if S_plus(bin_ut,curr_frame) > 0
                        salience_contour = [S_plus(bin_ut,curr_frame);salience_contour];
                        pitch_contour = [curr_bin;pitch_contour];
                        S_plus(bin_ut,curr_frame) = -1;
                        curr_bin = bin_ut;
                        gap_length = 0;
                        found = true;
                        no_val = false;
                        break 
                    end
                    
                    bin_ut = curr_bin + ii;
                    if S_plus(bin_ut,curr_frame) > 0
                        salience_contour = [S_plus(bin_ut,curr_frame);salience_contour];
                        pitch_contour = [curr_bin;pitch_contour];
                        S_plus(bin_ut,curr_frame) = -1;
                        curr_bin = bin_ut;
                        gap_length = 0;
                        found = true;
                        no_val = false;
                        break 
                    end
                end
            end
            if ~found
                for ii = 0:8
                    bin_ut = curr_bin - ii;
                    try
                        if S_minus(bin_ut,curr_frame) > 0
                            salience_contour = [S_minus(bin_ut,curr_frame);salience_contour];
                            pitch_contour = [curr_bin;pitch_contour];
                            S_minus(bin_ut,curr_frame) = -1;
                            curr_bin = bin_ut;
                            gap_length = gap_length + 1;
                            no_val = false;
                            break 
                        end
                        
                        bin_ut = curr_bin + ii;
                        if S_minus(bin_ut,curr_frame) > 0
                            salience_contour = [S_minus(bin_ut,curr_frame);salience_contour];
                            pitch_contour = [curr_bin;pitch_contour];
                            S_minus(bin_ut,curr_frame) = -1;
                            curr_bin = bin_ut;
                            gap_length = gap_length + 1;
                            no_val = false;
                            break 
                        end
                    end
                end
            end
                % disp(S(bin_ut,curr_frame+1));
            if no_val
                break;
            end
            curr_frame = curr_frame - 1;
        end
        
        if curr_frame ~= (start_frame - 1) 
            contour_start = curr_frame+1;
        end

        if curr_frame == 0
            contour_start = 1;
        end
        % if count == 1
        %     final_contour = {contour_start,contour_end,salience_contour,pitch_contour};
        % else
        %     final_contour = {final_contour;{contour_start,contour_end,salience_contour,pitch_contour}};
        % end

        final_contour{count,1} = contour_start;
        final_contour{count,2} = contour_end;
        final_contour{count,3} = pitch_contour;
        final_contour{count,4} = salience_contour;
        % final_contour{count,5} = length(salience_contour);
        % final_contour{count,6} = length(pitch_contour);
        count = count + 1;
    end

end