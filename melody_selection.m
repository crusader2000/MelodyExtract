% S = load('S.mat').S;

% IA = load('amplitude.mat').IA;
% IF = load('amplitude.mat').IF;


%%%% VOICING DETECTION %%%%%%%
final_contour = load('final_contour.mat').final_contour;
final_contour_characteristics = load('final_contour.mat').final_contour_characteristics;

n = size(final_contour,1);

filtered_contours = cell(1,7);

mean_mean_contour =  mean(cell2mat(final_contour_characteristics(:,3)));
std_mean_contour =  std(cell2mat(final_contour_characteristics(:,3)));
disp(mean_mean_contour);
disp(std_mean_contour);

voicing_threshold = mean_mean_contour - 0.2*std_mean_contour;

count = 1;
for ii = 1:n
    if final_contour_characteristics{ii,7} 
        filtered_contours(count,:) = final_contour_characteristics(ii,:);
        count = count + 1; 
    elseif final_contour_characteristics{ii,2} > 40 
        filtered_contours(count,:) = final_contour_characteristics(ii,:);
        count = count + 1; 
    elseif final_contour_characteristics{ii,3} >= voicing_threshold
        filtered_contours(count,:) = final_contour_characteristics(ii,:);
        count = count + 1; 
    end    
end

%%%% Octave Errors and Pitch Outliers %%%%%%%

