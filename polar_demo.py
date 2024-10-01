# An example of how we can plot polar coordinates and passively define our pot bounds in python. 
# This will coordinate with servo commands 
#    For each point along the path of the function: 
#        The radius and theta value will be sent to the servo control code. 
#        Theta will set the rotation value of the base servo (speed will need to be debugged and set to a value that allows smooth movement/time for the arm to move)
#        The radius will be used to partition extension values to each of the arm servos to achieve the proper extension from base to end of the arm.

import matplotlib.pyplot as plt
import numpy as np

def plt_circle(r):
    theta = np.arange(0, (2 * np.pi), 0.01)
    for t in theta:
        plt.polar(t, r, 'g.')
        
def plt_spiral(r_end):
    radius = np.linspace(0, r_end, 1000)
    theta = 2 * np.pi * radius
    plt.polar(theta, radius, 'r')
        

        
def plt_flower(num_petal, max_radius):
    theta = np.linspace(0, 2*np.pi, 1000)
    r = max_radius * np.sin(num_petal * theta)
    plt.polar(theta, r, 'r')

# r = 9 circle
plt.axes(projection = "polar")
#plt_circle(r)
#plt_spiral(3)
plt_flower(8, 5)

