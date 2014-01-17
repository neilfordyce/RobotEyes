% FUNCTION  X = REC3D(PL,PR,ul,vl,ur,vr)
% reconstructs 3D point co-ordinates, X, by triangulation,
% from left and right pixel coordinates of corresponding image points
% (ul,vl) and (ur,vr), given the left and right projection matrices PR and PL
%
function x = rec3D(PL,PR,ul,vl,ur,vr)

q1l = PL(1,1:3);
q2l = PL(2,1:3);
q3l = PL(3,1:3);
q1r = PR(1,1:3);
q2r = PR(2,1:3);
q3r = PR(3,1:3);

b = - [
  PL(1,4)-ul*PL(3,4) 
  PL(2,4)-vl*PL(3,4) 
  PR(1,4)-ur*PR(3,4) 
  PR(2,4)-vl*PR(3,4)    ];

A = [
  (q1l - ul*q3l)
  (q2l - vl*q3l)
  (q1r - ur*q3r)
  (q2r - vr*q3r)    ];
  
% least squares solution of the overconstrained system Ax=b
x = (A \ b)';

