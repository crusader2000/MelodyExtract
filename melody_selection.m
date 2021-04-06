% S = load('S.mat').S;

% IA = load('amplitude.mat').IA;
% IF = load('amplitude.mat').IF;

final_contour = load('final_contour.mat').final_contour;
final_contour_characteristics = load('final_contour.mat').final_contour_characteristics;

n = size(final_contour,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Contours with Vibrato
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sums = 0;
for ii = 1:168382
    x = final_contour_characteristics(ii,7);
    sums = sums + x{1};
end
disp(sums);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
