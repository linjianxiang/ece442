%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Question 2 Function Template
% Author : Adam Harrison
% If it suits you, you may keep this function's layout, which accepts block
% size, N1,N2,and the search range, R, as parameters.
%--------------------------------------------------------------------------
function  [Im_est Residual u v total_MAD]=ExhaustiveFind_Compensate(Im_ref,Im_cur,N1,N2,Range)

%If you've implemented Exhaustive_Search and Motion_Compensation properly,
%you shouldn't need to modify this function at all.

[u,v]=Exhaustive_Search(Im_ref,Im_cur,N1,N2,Range);

[Im_est Residual total_MAD]=Motion_Compensation(u,v,Im_ref,Im_cur,N1,N2);