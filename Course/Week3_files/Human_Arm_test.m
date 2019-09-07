%% Init model
clear

% Init Robotics Toolbox
mydir = pwd;
cd('U:\Kurser_undervisning\ITROB1\PeterCorke_Matlab_robotics\robot-10.2\rvctools')
startup_rvc
cd(mydir)

load Human_Arm_model

% Or try with UR 10 : 
% mdl_ur10

%% Inspect model

hum

%% Forward Kinematic
qn = [0 0.1 0.2 pi/2 pi/4 0];
T1 = hum.fkine(qn)
hum.plot(qn); %, 'workspace', [-10 10 -10 10 -10 10])
hum.teach()


%% Testing Inverse Kinematics
% Compare with built-in func
qn2 = hum.ikine(T1)
hum.plot(qn2); %, 'workspace', [-10 10 -10 10 -10 10])
hum.teach()



%% Generate path
xarr = -20:1:20; % y-values
yarr = 25*ones(size(xarr)); % x-values (constant)
zarr = 30*ones(size(xarr)); % z-values (constant)

Tinit = transl(xarr(1), yarr(1), zarr(1));
qseq = zeros(length(xarr), 6);
qseq(1,:)=hum.ikine(Tinit);
%  'ilimit',L     set the maximum iteration count (default 1000)
%   'tol',T        set the tolerance on error norm (default 1e-6)
%   'alpha',A      set step size gain (default 1)
  
for i= 2:length(xarr), % note: from i=2
    T = transl(xarr(i), yarr(i), zarr(i)); % homogeneous transform
    qseq(i,:) = hum.ikine(T, 'q0',qseq(i-1,:));
end

%% Plotting path

hum.plot(qseq, 'trail', 'r')

%% Symbolic expression derivation..
syms q1 q2 q3 q4 q5 q6

humsym = hum.sym();

Tsym = humsym.fkine([q1 q2 q3 q4 q5 q6])




