sums = 0;
for ii = 1:168382
    x = raw_contour_characteristics(ii,7);
    sums = sums + x{1};
end
disp(sums);