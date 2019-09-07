%% Init model
clear

% Init Robotics Toolbox
mydir = pwd;
cd('U:\Kurser_undervisning\ITROB1\PeterCorke_Matlab_robotics\robot-10.2\rvctools')
startup_rvc
cd(mydir)


%% Build 2-link robot

L1 = Revolute('d', 10, 'a', 0, 'alpha', pi/2)
L2 = Revolute('d', 0, 'a', 20, 'alpha', 0)
bot = SerialLink([L1, L2])

%%
bot.teach()
bot.fkine([0.1, 0.2])
