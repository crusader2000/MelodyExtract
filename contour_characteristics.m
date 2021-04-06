function final_contour_characteristics = contour_characteristics(final_contour)
    num_contours = size(final_contour,1);
    final_contour_characteristics = cell(num_contours,7);
    for ii = 1:num_contours
        pitch_mean = mean(final_contour{ii,3});
        pitch_std = std(final_contour{ii,3});
 
        salience_total = sum(final_contour{ii,4});
        salience_mean = mean(final_contour{ii,4});
        salience_std = std(final_contour{ii,4});

        contour_length = (final_contour{ii,2} - final_contour{ii,1} + 1);
        vibrato = false;
        if contour_length >= 5
            vibrato_fft = fft(final_contour{ii,3}-pitch_mean);
            if vibrato_fft(5) ~= 0 || vibrato_fft(5) ~= 0 || vibrato_fft(5) ~= 0
                vibrato = true;
            end
            % plot(1:contour_length,vibrato_fft);
        end
        final_contour_characteristics{ii,1} = pitch_mean;
        final_contour_characteristics{ii,2} = pitch_std;
        final_contour_characteristics{ii,3} = salience_mean;
        final_contour_characteristics{ii,4} = salience_total;
        final_contour_characteristics{ii,5} = salience_std;
        final_contour_characteristics{ii,6} = contour_length;
        final_contour_characteristics{ii,7} = int64(vibrato);
        % pause(1);
    end

end