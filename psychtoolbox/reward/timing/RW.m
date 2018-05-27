function [v_c, v_uc, prob, pe, lik] = RW(x,data)

%==========================================================================
%% Section 1: Preparation
%==========================================================================


%%%%%%%%%%%%    Modify      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%    Load data      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R       = data.out;
choice  = data.dec;
ntrial  = length(R);
pe      = zeros(ntrial,1);
v_c     = pe;
v_uc    = pe;
prob    = pe;

%%%%%%%%%%%%    Simulation      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v     = zeros(2,1);
b     = x(1);
lr    = x(2);
lik   = 0;


%%%%%%%%%%%%    Loop         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for n = 1:ntrial

    c  = choice(n);
    uc = 3-c;
    

    if c ~= 0
        
        v_c(n)  = v(c);
        v_uc(n) = v(uc);

        prob(n) = exp(b*v(c) - logsumexp(b*v,1));
    	lik = lik + b*v(c) - logsumexp(b*v,1);  % softmax choice probability
  		r = R(n);
  		pe(n) = r-v(c);
        v(c) = v(c) + lr*pe(n);

    else
        pe(n) = 0;

    end


end


end
