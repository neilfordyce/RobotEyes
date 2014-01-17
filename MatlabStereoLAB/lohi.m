function [R,t] = lohi(intrinsic,ul,vl,ur,vr)

% FUNCTION LOHI
% Longuet-Higgins 8-point algorithm;
% computes essential matrix E and camera rigid motion [R,t] from E;
% params are pixels correspondence (ul,vl) (ur,vr) and
% intrinsic parameters matrix, intrinsic


% normalize homogeneous coordinates
% (intrinsic parameters are  needed)
a1 = inv(intrinsic);
c2dln = a1*[ul vl ones(size(ul))]';
c2drn = a1*[ur vr ones(size(ur))]';

uln = (c2dln(1,:))';
vln = (c2dln(2,:))';

urn = (c2drn(1,:))';
vrn = (c2drn(2,:))';

A =[];
for i = 1:size(uln,1)

  col = [
    uln(i)*urn(i)
    uln(i)*vrn(i)
    uln(i)
    vln(i)*urn(i)
    vln(i)*vrn(i)
    vln(i)
         urn(i)
         vrn(i)
    1        ];

  A = [A col];
end

% solve A'e=0 subject to ||e||=1

[gevec, geval] = eig(A*A');
[y,i] = min(diag(geval));
% bring to zero practically 0 but negative values
y([y<0 & y>-0.0001]) = 0;

% if significantly negative eigenvalues exist, somthing wrong:
% exit with error
%
if y < 0
  error('negative eigenvalue')
end
e = gevec(:,i);

% esential matrix from f vector
E = reshape(e,3,3);

% use SVD factorisation to compute R and t

[U,D,V]= svd(E);

Z1=[
  0 -1 0
  1 0 0 
  0 0 0];

Z2=[
  0 1 0
  -1 0 0
  0 0 1];

for j = 1:5
  % skew symmetric matrix representing translation
  S= (1-2*rem(j,2)) * V * Z1  *V';

  % rotation matrix
  R = U * ((j>2)*Z2+(j<=2)*Z2') *V';

  % translation vector
  t = [  S(3,2) S(1,3) S(2,1) ]';

  end
