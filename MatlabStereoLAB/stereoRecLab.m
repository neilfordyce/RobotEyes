% TWO-CAMERA STEREO INTRODUCTION - TEACHING VERSION
% What: Set synthetic stereo pair parameters; reconstruct by triangulation
% Original version: Andrea Fusiello 1996
% Revisions: Manuel Trucco 2008, 2009

%%%%% SYSTEM SETUP
%%%%% Set values of system's parameters

% perspective projection matrix
% (left camera as world ref frame)
%
io = [ 
  1     0     0     0
  0     1     0     0
  0     0     1     0 ];
 
% intrinsic parameters: pixel size in mm, focal lengths in pixels,
% pixel co-ords of centre of image
%
pixsize = 0.02; % millimeters
fu = -12.1*(1/pixsize);
fv = -12.1*(1/pixsize);
u0 = 250;
v0 = 264;

% build matrix of intrinsic parameters (called "A" at lectures)
intrinsic = [ 
  -fu 0 u0
  0 -fv v0
  0  0  1 ];

% extrinsic parameters

% right cam location in world ref frame
% ("-" there to obtain the co-ord transformation

tra = - [-50 -20 -30]'

% pitch
phi = 5*pi/180; 
% roll
theta = -12*pi/180;
% yaw
psi = 9*pi/180;

% matrix giving the rotation of the reference frame
% of the right camera in the world ref frame (not transposed);
% Transposed to obtain the co-ord transformation matrix.
% rotation matrix with roll = phi, pitch = theta, yaw = psi
%

rotz = [
  cos(phi)  -sin(phi) 0
  sin(phi)   cos(phi) 0
  0             0     1]';

roty = [
  cos(theta)  0 sin(theta)
  0         1    0
  -sin(theta) 0 cos(theta)]';

rotx = [
  1         0    0
  0  cos(psi)  -sin(psi)
  0  sin(psi)   cos(psi)]';

rot = rotz*roty*rotx

extrinsic = [[rot tra]' [0 0 0 1]']'
 
%%%%%% END SYSTEM SETUP


%%%%%% ANALYSIS STARTS

% read 3D points from data file
 
% Linux or Unix escape to operating system command line
% to pick up only first 21 lines (21 points)
% ! tail +2l 3Dpoints  > m3Dpoints  

load m3Dpoints.dat  

% compute left camera view: 
% build proj matrix, then project points

pml = intrinsic * io;
[ul,vl]= proj(pml,m3Dpoints);

% compute right camera view (as above)

pmr = intrinsic * io * extrinsic ;
[ur,vr]= proj(pmr,m3Dpoints);

% plot left view
figure(1)
plot(ul,vl,'g+');
title('Left image');

% plot right view
figure(2)
plot(ur,vr,'rx');
title('Right image');

% compute and plot reconstructed point (3-D coords) and reconstruction
% error as norm of the difference vector given by true_vect - rec_vect
for i = 1:21
    true(i,:) = m3Dpoints(i,:);
    estimated(i,:) = rec3D(pml,pmr,ul(i),vl(i),ur(i),vr(i));
    err(i) = norm( true(i,:) - estimated(i,:) );
end

figure;
plot(err);
title('reconstruction error per point - diff vector norm [mm]');
xlabel('point index');

% compute and plot reconstruction error = abs difference btw true and
% est'd values of each coord (X, Y, Z), as % of range
% of each coord
figure;
for i = 1:21
   xerr(i) = abs(true(i,1) - estimated(i,1));
   yerr(i) = abs(true(i,2) - estimated(i,2));
   zerr(i) = abs(true(i,3) - estimated(i,3));
end   
rx = abs( max(m3Dpoints(:,1))-min(m3Dpoints(:,1)) );
ry = abs( max(m3Dpoints(:,2))-min(m3Dpoints(:,2)) );
rz = abs( max(m3Dpoints(:,2))-min(m3Dpoints(:,3)) );
plot(100*xerr/rx,'b'); hold on;
plot(100*yerr/ry,'r');
plot(100*zerr/rz,'g');

title('% abs error on X, Y, Z (wrt co-ords range)');
xlabel('point index'); ylabel('b = X; r = Y; g = Z');
hold off;

fprintf('ranges X, Y, Z = %d, %d, %d\n', rx, ry, rz);
fprintf('min, max and mean coords:\n');
fprintf('X: %.2f %.2f %.2f,  Y: %.2f %.2f %.2f,  Z: %.2f %.2f %.2f ', min(m3Dpoints(:,1)), max(m3Dpoints(:,1)), mean(m3Dpoints(:,1)),    min(m3Dpoints(:,2)), max(m3Dpoints(:,2)), mean(m3Dpoints(:,2)),  min(m3Dpoints(:,3)), max(m3Dpoints(:,3)), mean(m3Dpoints(:,3))  );
