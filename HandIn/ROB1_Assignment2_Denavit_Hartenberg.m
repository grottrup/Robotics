%% Lengths and angles of links and joints in the robot

shoulder_elb = 11;
elb1_elb2 = 17;
elb2_wri = 6.5;
wri_tip = 16.5;


%% Use Denavit-Hartenberg convention to establish coordinate frames for the robot
% Extract the DH parameters from the model

% Defines transition to next coordinate. Rotated pi/2 for elbow joint
L1 = Revolute('d', shoulder_elb, 'alpha', pi/2);
L2 = Revolute('a', elb1_elb2, 'alpha', 0);
L3 = Revolute('a', elb2_wri, 'alpha', -pi/2);
L4 = Revolute('d', wri_tip, 'alpha', 0);

robot = SerialLink([L1, L2, L3, L4]);

qn = [0 0.1 0.2 pi/2 pi/4 0];
robot.plot(qn);

