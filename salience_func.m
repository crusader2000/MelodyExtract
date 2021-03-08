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
    alpha = 1;
    mag_comp = 2;

    for frame_num = 1:N
        aM = max(IA(:,frame_num));
        for b = 1:600
            for h = 1:Nh
                % disp(mag_threshold(aM,IA(:,frame_num),threshold).*weighting_func(b,h,IF(:,frame_num),B(floor(IF(:,frame_num)/h)),alpha).*power(IA(:,frame_num),mag_comp));
                S(b,frame_num) = sum(mag_threshold(aM,IA(:,frame_num),threshold).*weighting_func(b,h,IF(:,frame_num),B(floor(IF(:,frame_num)/h)),alpha).*power(IA(:,frame_num),mag_comp));
            end
        end
    end
    % save("S.mat",'S');
    % disp(S);
    % contourf(S);
end

function val = mag_threshold(aM,ai,threshold)
    val = int64(20*log(aM./ai) < threshold);
    % disp("mag_threshold");
    % disp(val);
end

function val = weighting_func(b,h,f,bin,alpha)    
    if length(f) > 1
        val = zeros(size(f));
    else 
        val = 0;
    end
    
    % disp(bin);
    delta = abs(bin-b)/10;

    for ii = 1:length(val)
        if delta(ii) <= 1
            val(ii) = power(cos((delta(ii)*pi)/2),2)*power(alpha,h-1);
            % disp("weighting_func");
            % disp(val(ii));
        else
            val(ii) = 0;
        end 
    end

    % disp(val);
end