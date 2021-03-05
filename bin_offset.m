function offset = bin_offset(a,b,k,N,H)
    offset = (N/(2*pi*H))*principal_arg(a-b-((2*pi*H)/N)*k);
    % disp(offset);
end

function val = principal_arg(x)
    val = angle(exp(1i*x));
    % disp("prinipal_arg");
    % disp(x);
    % disp(val);
end