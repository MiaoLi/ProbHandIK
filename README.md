# ProbHandIK
The probabilistic hand inverse kinematics.

Dependence: OpenRAVE

## Sampling hand joint data and train the model
we use Allegro hand as an example and we also have the code for Barrett hand in this package.

1. Run `AhandRS.py` in pythoncode folder and the data will be saved into `AllegroHandData.txt`;

2. Run `AllegrohandIK.m` in matlabcode folder train the model;

3. Run `AllegrohandIKSolve.m` in matlabcode folder to solve the IK for the optimal grasps you found in the package GPIS.


