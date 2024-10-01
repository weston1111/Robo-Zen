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

