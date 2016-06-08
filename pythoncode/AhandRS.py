#!/usr/bin/python
"""
miao.li@epfl.ch
This file is used to generate the hand configuration and 
the encoder for hand inverse kinematics

"""

from openravepy import *
import random
import math, time
from numpy import *
from openravepy import misc
if not __openravepy_build_doc__:
    from openravepy import *
    from numpy import *
import time, threading
from MiaoFunc import *


class PlotSpinner(threading.Thread):
    def __init__(self,handle):
        threading.Thread.__init__(self)
        self.starttime = time.time()
        self.handle=handle
        self.ok = True
    def run(self):
        while self.ok:
            self.handle.SetShow(bool(mod(time.time()-self.starttime,2.0) < 2.0))
            #time.sleep(0.0001)


vis = True

#v = raw_input("Visualization? : [y/n]\n")
#if (v == 'y'):
#	vis = True

objname = 'spray'

env = Environment() # create openrave environment
if (vis):
	env.SetViewer('qtcoin') # attach viewer (optional)
env.Load('../models/allegroTac.robot.xml') 
robot = env.GetRobots()[0] # get the first robot
#obj = env.ReadKinBodyXMLFile('./Models/' + objname + '.kinbody.xml')
#env.Add(obj)


time.sleep(0.2)

nbSample = 1000000

raw_input('press Enter to continue')
handles = []
AHandData = []
nbValid = 0
with env: # lock the environment since robot will be used
		lower,upper = robot.GetActiveDOFLimits()
		for i in range(nbSample):
			print i
			#raw_input('press Enter to continue')
			JntTarget = numpy.random.rand(len(lower))*(upper-lower)+lower
			#print JntTarget
			robot.SetDOFValues([JntTarget[0]],[0])
			robot.SetDOFValues([JntTarget[1]],[1])
			robot.SetDOFValues([JntTarget[2]],[2])
			robot.SetDOFValues([JntTarget[3]],[3])
			robot.SetDOFValues([JntTarget[4]],[4])
			robot.SetDOFValues([JntTarget[5]],[5])
			robot.SetDOFValues([JntTarget[6]],[6])
			robot.SetDOFValues([JntTarget[7]],[7])
			robot.SetDOFValues([JntTarget[12]],[12])
			robot.SetDOFValues([JntTarget[13]],[13])
			robot.SetDOFValues([JntTarget[14]],[14])
			robot.SetDOFValues([JntTarget[15]],[15])

			if not robot.CheckSelfCollision():

				T0 = robot.GetLinks()[5].GetGlobalMassFrame()
				T1 = robot.GetLinks()[10].GetGlobalMassFrame()
				T2 = robot.GetLinks()[20].GetGlobalMassFrame()

				T0[0:3,3] = T0[0:3,3] + 0.01*T0[0:3,1]+0.065*T0[0:3,0];
				T1[0:3,3] = T1[0:3,3] + 0.01*T1[0:3,1]+0.065*T1[0:3,0];
				T2[0:3,3] = T2[0:3,3] + 0.01*T2[0:3,1]+0.095*T2[0:3,0];
				datanew = concatenate([JntTarget[0:8],JntTarget[12:16],T0[0:3,3],T1[0:3,3],T2[0:3,3],T0[0:3,1],T1[0:3,1],T2[0:3,1]])
				AHandData.append(datanew) 

				#AHandData[nbValid,0:8] = JntTarget[0:8]
				#AHandData[nbValid,8:12] = JntTarget[12:16]
				#AHandData[nbValid,12:15] = T0[0:3,3]
				#AHandData[nbValid,15:18] = T1[0:3,3]
				#AHandData[nbValid,18:21] = T2[0:3,3]
				#AHandData[nbValid,21:24] = T0[0:3,1]
				#AHandData[nbValid,24:27] = T1[0:3,1]
				#AHandData[nbValid,27:30] = T2[0:3,1]
				nbValid  = nbValid +1

				if(vis):
					try:
						handles = []
						framescale =0.06
						#h1 = env.drawlinestrip(points=array((T0[0:3,3],T0[0:3,3]+T0[0:3,0]*framescale)),linewidth=8.0, colors=array(((1,0,0,0.5))))
						#h2 = env.drawlinestrip(points=array((T0[0:3,3],T0[0:3,3]+T0[0:3,1]*framescale)),linewidth=8.0, colors=array(((0,1,0,0.5))))
						#h3 = env.drawlinestrip(points=array((T0[0:3,3],T0[0:3,3]+T0[0:3,2]*framescale)),linewidth=8.0, colors=array(((0,0,1,0.5))))

						#h4 = env.drawlinestrip(points=array((T1[0:3,3],T1[0:3,3]+T1[0:3,0]*framescale)),linewidth=8.0, colors=array(((1,0,0,0.5))))
						#h5 = env.drawlinestrip(points=array((T1[0:3,3],T1[0:3,3]+T1[0:3,1]*framescale)),linewidth=8.0, colors=array(((0,1,0,0.5))))
						#h6 = env.drawlinestrip(points=array((T1[0:3,3],T1[0:3,3]+T1[0:3,2]*framescale)),linewidth=8.0, colors=array(((0,0,1,0.5))))

						#h7 = env.drawlinestrip(points=array((T2[0:3,3],T2[0:3,3]+T2[0:3,0]*framescale)),linewidth=8.0, colors=array(((1,0,0,0.5))))
						#h8 = env.drawlinestrip(points=array((T2[0:3,3],T2[0:3,3]+T2[0:3,1]*framescale)),linewidth=8.0, colors=array(((0,1,0,0.5))))
						#h9 = env.drawlinestrip(points=array((T2[0:3,3],T2[0:3,3]+T2[0:3,2]*framescale)),linewidth=8.0, colors=array(((0,0,1,0.5))))

						#htmp2 = PlotTransformation(T1,env,0.05)
						#htmp3 = PlotTransformation(T2,env,0.05)
						#handles.append(htmp1)
						#handles.append(htmp2)
						#handles.append(htmp3)
						#handles.append(h1)
						#handles.append(h2)
						#handles.append(h3)
						#handles.append(h4)
						#handles.append(h5)
						#handles.append(h6)
						#handles.append(h7)
						#handles.append(h8)
						#handles.append(h9)
						VFHand = VirtualFrame(T0[0:3,3],T1[0:3,3],T2[0:3,3])
						h1 = env.drawlinestrip(points=array((VFHand[0:3,3],VFHand[0:3,3]+VFHand[0:3,0]*framescale)),linewidth=8.0, colors=array(((1,0,0,0.5))))
						h2 = env.drawlinestrip(points=array((VFHand[0:3,3],VFHand[0:3,3]+VFHand[0:3,1]*framescale)),linewidth=8.0, colors=array(((0,1,0,0.5))))
						h3 = env.drawlinestrip(points=array((VFHand[0:3,3],VFHand[0:3,3]+VFHand[0:3,2]*framescale)),linewidth=8.0, colors=array(((0,0,1,0.5))))
						handles.append(h1)
						handles.append(h2)
						handles.append(h3)
						handles.append(env.drawtrimesh(points=array((T0[0:3,3],T1[0:3,3],T2[0:3,3])),
                                         indices=None,
                                         colors=array(((1,0,0,0.6),(0,1,0,0.6),(0,0,1,0.6)))))
						env.UpdatePublishedBodies()
						spinner = PlotSpinner(handles[-1])
						spinner.start()
						#raw_input('press Enter to continue')
						time.sleep(0.1)
					finally:
						if spinner is not None:
						  spinner.ok = False

numpy.savetxt('AllegroHandData.txt',AHandData)
print nbValid
print('The number of valid sample is : '  + str(size(AHandData,0)))
raw_input('press Enter to exit')
