function [S] = salience_func(IA,IF,Nh)
    % Nh - Number of Harmonics Considered
    
    % Number of Frames
    N = size(IF,2);

    % Number of peaks considered in each frame
    I = size(IF,1);

    % Calculate B(f)
    % B(ii) contains the bin of IF(ii)
    bin = zeros(size(IF));

    for ii = 1:I
        for jj = 1:N
            B(ii,jj) = floor((1200*log2(IF(ii,jj)/55)/10)+1);        
        end
    end
    
    bins = 1:600;

    S = zeros(600,N);

    % PARAMETERS
    threshold = 8;
    alpha = 0.5;
    
    for frame_num = 1:N
        aM = max(IA(:,frame_num));
        for b = 1:600
            for hh = 1:Nh
                S(b,frame_num) = sum(mag_threshold(aM,IA(:,frame_num),threshold).*weighting_func(b,h,IF(:,frame_num),B(floor(IF(:,frame_num)/h)),alpha));
            end
        end
    end

end

function val = mag_threshold(aM,ai,threshold)
    val = int64(20*log(aM./ai) < threshold);
end

function val = weighting_func(b,h,f,bin,alpha)    
    val = zeros(size(f));
    delta = abs(bin-b)/10;

    for ii = 1:length(val)
        if delta(ii) <= 1
            val(ii) = pow(cos((delta(ii)*pi)/2),2)*pow(alpha,h-1);
        else
            val(ii) = 0;
        end 
    end
end