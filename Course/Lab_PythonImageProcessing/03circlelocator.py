# -*- coding: utf-8 -*-
"""
Python program til at finde røde cirkler i film.

Skrevet af: Mads Dyrmann and Henrik Skov Midtiby

"""

import cv2

def main():
    cap = cv2.VideoCapture('MVI_0069.MOV')
    
    if int(cv2.__version__[0])>=3: #if opencv 3.0
        fourcc = cv2.VideoWriter_fourcc(*'H264')
    else:
        fourcc = cv2.CV_FOURCC(*'H264')
        
    VidOut = cv2.VideoWriter('output.mp4',fourcc,10,(480,640))    
    
    while(cap.isOpened()):
        # Read next frame
        ret, frame = cap.read()

        if not ret:
            break        
        
        # Show current frame
        cv2.imshow('frame', frame)

        print(frame.shape)
        # split the color channels
        red=frame[:,:,2] 
        green=frame[:,:,1] 
        blue=frame[:,:,0] 
        
        # Calculate excess red and threshold
        temp = cv2.addWeighted(red, 0.4, green, -0.2, 50)
        exr = cv2.addWeighted(temp, 1, blue, -0.2, 0)
        
        # Find places with an exr value over 80 (it suits for this video, but probably not yours)
        retval, thrsholdeded = cv2.threshold(exr, 80, 255, cv2.THRESH_BINARY)
        
        # show the thresholded image
        cv2.imshow('exr', thrsholdeded)

        # Find connected components
        contours, hierarchy = cv2.findContours(thrsholdeded, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)        

        # loop through connected components
        for cnt in contours:
            # Calculate area and circumference
            area = cv2.contourArea(cnt)
            circumference = cv2.arcLength(cnt, True)
            
            # Do something if area is greated than 1.
            if(area > 1):
                # Determine if the contour looks like a circle
                #
                # <alter these lines>
                # Change the "if-statement", so that it is only true for circles
                if(1 < 2):
                # </alter these lines>        
                    # Calculate the centre of mass
                    M = cv2.moments(cnt)
                    cx = int(M['m10']/M['m00'])
                    cy = int(M['m01']/M['m00'])
                    #print(cx, cy)
                    
                    # Draw a cross-hair on the circle
                    # <alter these lines>        
                    point1 = (0, 0)
                    point2 = (cx, cy)
                    cv2.line(frame, point1, point2, (255, 0, 0), 4)
                    cv2.circle(frame, (cx, cy), 20, (255, 0, 255), -1)
                    # </alter these lines>        

        cv2.imshow('frame annotated', frame)
        VidOut.write(frame)


        if cv2.waitKey(10) & 0xFF == ord('q'):
            break
    VidOut.release()
    return    


main()
