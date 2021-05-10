% S = load('S.mat').S;

% IA = load('amplitude.mat').IA;
% IF = load('amplitude.mat').IF;


%%%% VOICING DETECTION %%%%%%%
% raw_contour = load('raw_contour.mat').raw_contour;
% raw_contour_characteristics = load('raw_contour.mat').raw_contour_characteristics;

function filtered_contours = melody_selection(raw_contour,raw_contour_characteristics)
    n = size(raw_contour,1);

    filtered_contours = cell(1,11);
    % This contains
    % 1 - contour_start
    % 2 - contour_end
    % 3 - pitch_contour
    % 4 - salience_contour
    % 5 - pitch_mean
    % 6 - pitch_std
    % 7 - salience_mean
    % 8 - salience_total
    % 9 - salience_std
    % 10 - contour_length
    % 11 - int64(vibrato) - Yes/No
    
    mean_mean_contour =  mean(cell2mat(raw_contour_characteristics(:,3)));
    std_mean_contour =  std(cell2mat(raw_contour_characteristics(:,3)));
    disp("mean_mean_contour");
    disp(mean_mean_contour);
    disp("std_mean_contour");
    disp(std_mean_contour);
    
    % voicing_threshold = mean_mean_contour - 0.1*std_mean_contour;
    voicing_threshold = mean_mean_contour;
    
    count = 1;
    for ii = 1:n
        if raw_contour_characteristics{ii,7} 
            filtered_contours(count,1:4) = raw_contour(ii,:);
            filtered_contours(count,5:11) = raw_contour_characteristics(ii,:);
            count = count + 1; 
        elseif raw_contour_characteristics{ii,2} > 40 
            filtered_contours(count,1:4) = raw_contour(ii,:);
            filtered_contours(count,5:11) = raw_contour_characteristics(ii,:);
            count = count + 1; 
        elseif raw_contour_characteristics{ii,3} >= voicing_threshold
            filtered_contours(count,1:4) = raw_contour(ii,:);
            filtered_contours(count,5:11) = raw_contour_characteristics(ii,:);
            count = count + 1; 
        end    
    end
    
    %%%% Octave Errors and Pitch Outliers %%%%%%%
     
end