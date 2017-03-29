%--------------------------------------------------------------------------
% EE442 Lab4 Video Processing 
% Question 3 Function Template
% Author : Adam Harrison
%--------------------------------------------------------------------------
function  [Im_est Residual u v total_MAD]=LogFind_Compensate(Im_ref,Im_cur,N1,N2,Range)

%If you've implemented Log_Search and Motion_Compensation properly,
%you shouldn't need to modify this function very much.


[u,v]=Log_Search(Im_ref,Im_cur,N1,N2,Range);

[Im_est Residual total_MAD]=Motion_Compensation(u,v,Im_ref,Im_cur,N1,N2);