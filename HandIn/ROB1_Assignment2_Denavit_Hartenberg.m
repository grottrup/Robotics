%% Lengths and angles of links and joints in the robot
clear
clc
close all

base_shoulder = 0; % value doesn't matter that much and we didn't read it yet
shoulder_elb = 11;
elb1_elb2 = 17;
elb2_wri = 6.5;
wri_tip = 16.5;

%% Calculate the transformation A-matrices between frames and the full tranformation matrix T
syms theta1 theta2 theta3 theta4 theta5 theta6

% Extract the DH parameters from the model
theta = [theta1, theta2, theta3, theta4, theta5, theta6];
a = [0, 0, elb1_elb2, elb2_wri, 0, 0];
d = [base_shoulder, shoulder_elb, 0, 0, 0, wri_tip];
alpha = [0, pi/2, 0, -pi/2, pi/2, 0];

%calculate the A matrices between frames
for j=1:6
    A(:,:,j) = [ cos(theta(j)) -sin(theta(j))*cos(alpha(j)) sin(theta(j))*sin(alpha(j)) a(j)*cos(theta(j)); 
              sin(theta(j)) cos(theta(j))*cos(alpha(j)) -cos(theta(j))*sin(alpha(j)) alpha(j)*sin(theta(j)); 
              0 sin(alpha(j)) cos(alpha(j)) d(j); 
              0 0 0 1];
end

%calculate the full tranformation matrix T
T= A(:,:,1)*A(:,:,2)*A(:,:,3)*A(:,:,4)*A(:,:,5)*A(:,:,6);

%% Use Denavit-Hartenberg convention to establish coordinate frames for the robot
% Extract the DH parameters from the model

% Defines transition to next coordinate. Rotated pi/2 for elbow joint
L1 = Revolute('d', d(1), 'alpha', alpha(1));
L2 = Revolute('d', d(2), 'alpha', alpha(2));
L3 = Revolute('a', a(3), 'alpha', alpha(3));
L4 = Revolute('a', a(4), 'alpha', alpha(4));
L5 = Revolute('d', d(5), 'alpha', alpha(5));
L6 = Revolute('d', d(6), 'alpha', alpha(6));



robot = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'Crustcrawler');

%% Calculate the full transformation ??0 between base and end effector frames

theta = [0 0 pi/2 0 pi/2 0];
T1 = robot.fkine(theta)
robot.plot(theta);
%robot.teach()

%%
T2 = robot.ikine(T1)
