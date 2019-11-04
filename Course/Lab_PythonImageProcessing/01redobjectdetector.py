# -*- coding: utf-8 -*-
"""
Detect red objects in images

Skrevet af: Mads Dyrmann and Henrik Skov Midtiby
Dato: 2014-10-06

Versionshistorik:
2015-10-19: Tilpasset til OpenCV3.0
"""

import cv2.filter2d
#import numpy as np

# def main():
#     # Read image
#     frame = cv2.imread('billede.png')
    
#     # Show image on screen
#     cv2.imshow('frame', frame)

#     # Extract the three color channels,
#     red=frame[:,:,2] 
#     green=frame[:,:,1] 
#     blue=frame[:,:,0] 
    
#     # Calculate excess red
#     #  <alter these lines>        
#     #exr = 
    
#     # Find suitable threshold
#     #thresholded = 
#     # </alter these lines>        
    

    
#     # show those areas
#     cv2.imshow('exr', thresholded)

#     # Find connected components
#     contours, hierarchy = cv2.findContours(thresholded, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
#     # loop through all components, one at the time
#     for cnt in contours:
#         # Whats the area of the component?
#         areal = cv2.contourArea(cnt)
        
#         # Gør noget hvis arealet er større end 1.
#         if(areal > 1):
#             # get the center of mass
#             M = cv2.moments(cnt)
#             cx = int(M['m10']/M['m00'])
#             cy = int(M['m01']/M['m00'])
#             #print(cx, cy)
            
#             #alternativ
#             # cx=sum(cnt[:,0][:,0])/len(cnt[:,0][:,0])
#             # cy=sum(cnt[:,0][:,1])/len(cnt[:,0][:,1])
#             # print cx1,cy1
            
            
#             # Tegn et sigtekorn på billedet, der markerer elementet.
#             # <alter these lines>
            
#             # </alter these lines>        

#     cv2.imshow('frame annotated', frame)

#     cv2.waitKey(0)

#     return    


# main()