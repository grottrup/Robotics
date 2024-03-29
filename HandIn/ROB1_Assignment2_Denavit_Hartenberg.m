%% Lengths and angles of links and joints in the robot
clear
clc
close all

base_shoulder = 0;
shoulder_elb = 11;
elb_wristflex = 17;
wristflex_wristrotate = 6.5;
wristrotate_tip = 16.5;

%% Use Denavit-Hartenberg convention to establish coordinate frames for the robot
syms theta1 theta2 theta3 theta4 theta5 theta6

% Extract the DH parameters from the model
theta = [theta1, theta2, theta3, theta4, theta5, theta6];
a = [0, 0, elb_wristflex, wristflex_wristrotate, 0, 0];
d = [base_shoulder, shoulder_elb, 0, 0, 0, wristrotate_tip];
alpha = [0, pi/2, 0, -pi/2, pi/2, 0];

% Defines transition to next coordinate. Rotated pi/2 for elbow joint
L1 = Revolute('d', d(1), 'alpha', alpha(1));
L2 = Revolute('d', d(2), 'alpha', alpha(2));
L3 = Revolute('a', a(3), 'alpha', alpha(3));
L4 = Revolute('a', a(4), 'alpha', alpha(4));
L5 = Revolute('d', d(5), 'alpha', alpha(5));
L6 = Revolute('d', d(6), 'alpha', alpha(6));

robot = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'Crustcrawler');

%% Calculate the transformation A-matrices between frames and the full tranformation matrix T
%calculate the A matrices between frames
for j=1:6
    A(:,:,j) = [ cos(theta(j)) -sin(theta(j))*cos(alpha(j)) sin(theta(j))*sin(alpha(j)) a(j)*cos(theta(j)); 
              sin(theta(j)) cos(theta(j))*cos(alpha(j)) -cos(theta(j))*sin(alpha(j)) alpha(j)*sin(theta(j)); 
              0 sin(alpha(j)) cos(alpha(j)) d(j); 
              0 0 0 1];
end

%calculate the full tranformation matrix T
T= A(:,:,1)*A(:,:,2)*A(:,:,3)*A(:,:,4)*A(:,:,5)*A(:,:,6);
%% Calculate the full transformation ??0 between base and end effector frames

theta = [0 0 pi/2 0 pi/2 0];
T1 = robot.fkine(theta)
robot.plot(theta);
robot.teach()

%%
T2 = robot.ikine(T1)


%%
yarr = -16.5:1:16.5; % y-values
zarr = 11*ones(size(yarr)); % z-values (constant)
xarr = 23.5*ones(size(yarr)); % x-values (constant)

Tinit = transl(xarr(1), yarr(1), zarr(1))
ikineTinit = robot.ikcon(Tinit)
qseq = zeros(length(xarr), 6);
qseq(1,:) = robot.ikcon(Tinit);
%  'ilimit',L     set the maximum iteration count (default 1000)
%   'tol',T        set the tolerance on error norm (default 1e-6)
%   'alpha',A      set step size gain (default 1)
  
for i= 2:length(xarr), % note: from i=2
    T = transl(xarr(i), yarr(i), zarr(i)); % homogeneous transform
    qseq(i,:) = robot.ikcon(T);
end

robot.plot(qseq, 'trail', 'r')