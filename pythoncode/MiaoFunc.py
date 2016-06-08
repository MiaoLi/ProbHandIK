
#!/usr/bin/python

from openravepy import *
import random
import math, time
from numpy import *
from openravepy import misc
if not __openravepy_build_doc__:
    from openravepy import *
    from numpy import *

from numpy import linalg as LA
from numpy.linalg import inv
from jointConstrains import *
from transformations import *

tipOffsetsAhand = array([[0.065,0.01,0], [0.065,0.01,0], [0.065,0.01,0],[0.095,0.01,0]])
tipOffsetsBhand = array([[0.025,0.01,0], [0.025,0.01,0], [0.025,0.01,0]])
endEffectorsAhand= array([5, 10, 15, 20])
endEffectorsBhand = array([3, 6, 8])
def PlotTransformation(T, env, framescale):
	#plot the coordinate frame given a transformation
	h1=env.drawlinestrip(points=array((T[0:3,3],T[0:3,3]+T[0:3,0]*framescale)),linewidth=5.0, colors=array(((1,0,0,0.5))))
	h2=env.drawlinestrip(points=array((T[0:3,3],T[0:3,3]+T[0:3,1]*framescale)),linewidth=5.0, colors=array(((0,1,0,0.5))))
	h3=env.drawlinestrip(points=array((T[0:3,3],T[0:3,3]+T[0:3,2]*framescale)),linewidth=5.0, colors=array(((0,0,1,0.5))))
	return [h1,h2,h3]

def VirtualFrame(p1, p2, p3):
	T = eye(4,4)
	T[0:3,0] = (p3-p1)/LA.norm(p3-p1)
	T[0:3,2] = numpy.cross(p2-p1, T[0:3,0])
	T[0:3,2] = T[0:3,2]/LA.norm(T[0:3,2])
	T[0:3,1] = numpy.cross(T[0:3,2],T[0:3,0]) 
	T[0:3,3] = (p1+p2+p3)/3
	return T
def contactsDiff(posValues,normalValues,refValues):
	d = 0
	for i in range(len(posValues)):
		d += numpy.linalg.norm(posValues[i] - refValues[i])
	for i in range(len(normalValues)):
		d= d + 0.1*(dot(normalValues[i], refValues[i+3])+1)**2 
	return d

def AhandObjFunc(x, *params):
	refValues, robot = params
	RAxis = x[16:19]
	Rt = x[19]
	M =rotation_matrix(Rt, RAxis)
	M[0:3,3] = x[20:]

	robot.SetTransform(M)
	robot.SetDOFValues(x[0:16], range(16))

	posValues = []
	normalValues =[]
	for i in array([0,1,3]):
		T = robot.GetLinks()[endEffectorsAhand[i]].GetGlobalMassFrame()
		offset = tipOffsetsAhand[i].dot(inv(T[0:3,0:3]))
		T[0:3,3] = T[0:3,3] + offset
		posValues.append(T[0:3,3])
		normalValues.append(T[0:3,1])
	
	return contactsDiff(posValues, normalValues,refValues)

def BhandObjFunc(x,*params):
	refValues, robot = params
	RAxis = x[4:7]
	Rt = x[7]
	M =rotation_matrix(Rt, RAxis)
	M[0:3,3] = x[8:]

	robot.SetTransform(M)
	robot.SetDOFValues(x[0:4], range(4))

	posValues = []
	normalValues =[]
	for i in array([0,1,2]):
		T = robot.GetLinks()[endEffectorsBhand[i]].GetGlobalMassFrame()
		offset = tipOffsetsBhand[i].dot(inv(T[0:3,0:3]))
		T[0:3,3] = T[0:3,3] + offset
		posValues.append(T[0:3,3])
		normalValues.append(T[0:3,1])

	return contactsDiff(posValues, normalValues,refValues)



