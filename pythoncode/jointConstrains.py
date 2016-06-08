#!/usr/bin/python

def jointConstr0(x,*params):
	i = 0
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return (x[i] - lower[i])
	else:
		return (upper[i] - x[i])


def jointConstr1(x,*params):
	i = 1
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return (x[i] - lower[i])
	else:
		return (upper[i] - x[i])


def jointConstr2(x,*params):
	i = 2
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return (x[i] - lower[i])
	else:
		return (upper[i] - x[i])


def jointConstr3(x,*params):
	i = 3
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return (x[i] - lower[i])
	else:
		return (upper[i] - x[i])


def jointConstr4(x,*params):
	i = 4
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr5(x,*params):
	i = 5
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr6(x,*params):
	i = 6
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr7(x,*params):
	i = 7
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr8(x,*params):
	i = 8
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr9(x,*params):
	i = 9
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr10(x,*params):
	i = 10
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr11(x,*params):
	i = 11
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr12(x,*params):
	i = 12
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr13(x,*params):
	i = 13
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr14(x,*params):
	i = 14
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]


def jointConstr15(x,*params):
	i = 15
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i] < lower[i]:
		return x[i] - lower[i]
	else:
		return upper[i] - x[i]



def thumbConstr12(x,*params):
	i = 12
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i-12] < lower[i]:
		return x[i-12] - lower[i]
	else:
		return upper[i] - x[i-12]


def thumbConstr13(x,*params):
	i = 13
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i-12] < lower[i]:
		return x[i-12] - lower[i]
	else:
		return upper[i] - x[i-12]


def thumbConstr14(x,*params):
	i = 14
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i-12] < lower[i]:
		return x[i-12] - lower[i]
	else:
		return upper[i] - x[i-12]


def thumbConstr15(x,*params):
	i = 15
	refValues, robot = params
	lower, upper = robot.GetDOFLimits()
	if x[i-12] < lower[i]:
		return x[i-12] - lower[i]
	else:
		return upper[i] - x[i-12]


# def jointConstrCollision(x, *params):
# 	refValues, robot = params
# 	robot.SetDOFValues(x[0:16], range(16))
# 	if robot.CheckSelfCollision():
# 		return -1
# 	return 1