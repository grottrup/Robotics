%% Lengths and angles of links and joints in the robot
clear

base_shoulder = 0; % value doesn't matter that much and we didn't read it yet
shoulder_elb = 11;
elb1_elb2 = 17;
elb2_wri = 6.5;
wri_tip = 16.5;


%% Use Denavit-Hartenberg convention to establish coordinate frames for the robot
% Extract the DH parameters from the model

% Defines transition to next coordinate. Rotated pi/2 for elbow joint
L1 = Revolute('d', base_shoulder, 'alpha', pi/2);
L2 = Revolute('d', shoulder_elb, 'alpha', pi/2);
L3 = Revolute('a', elb1_elb2, 'alpha', 0);
L4 = Revolute('a', elb2_wri, 'alpha', -pi/2);
L5 = Revolute('d', wri_tip, 'alpha', 0);

robot = SerialLink([L1, L2, L3, L4, L5]);

%% Calculate the transformation A-matrices between frames
syms theta1 theta2 theta3 theta4 theta5 

theta = [theta1, theta2, theta3, theta4, theta5];
a = [0, 0, 0, 0, 0];
d = [0, 0, 0, 0, 0];
alpha = [0, 0, 0, 0, 0];
A = [0, 0, 0, 0, 0];

for j=1:5
    A(j) =   [ cos(theta(j)) -sin(theta(j))*cos(alpha(j)) sin(theta(j))*sin(alpha(j)) a(j)*cos(theta(j)); 
              sin(theta(j)) cos(theta(j))*cos(alpha(j)) -cos(theta(j))*sin(alpha(j)) alpha(j)*sin(theta(j)); 
              0 sin(alpha(j)) cos(alpha(j)) d(j); 
              0 0 0 1];
end
%% Calculate the full transformation ??0 between base and end effector frames

%robot.teach()
%robot.fkine([0.1, 0.2])

%syms q1 q2 q3 q4 q5 q6

%crustcrawler_symbolic = crustcrawler.sym();

%Tsym = crustcrawler_symbolic.fkine([q1 q2 q3 q4 q5 q6])