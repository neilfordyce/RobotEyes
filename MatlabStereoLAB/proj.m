% FUNCTION PROJ
% Projects 3-D points in c3d onto image plane.
% Projection defined by matrix P.
% Returns co-ordinates of image points.
%
function [u v] = proj(P, c3d)

h3d =[c3d ones(size(c3d,1),1)]';
h2d = P*h3d ;  %% image points in projective co-ords

% convert Euclidean plane co-ordinates
%
c2d = h2d(1:2,:)./ [h2d(3,:)' h2d(3,:)']';

% final co-ordinate lists
u = (c2d(1,:))';
v = (c2d(2,:))'; 