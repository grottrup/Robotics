#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 12:25:39 2019

@author: mads
"""


import cv2
import time
# Disable user control in
# Go to http://192.168.0.20 and select maintanance


stream_addr = 'http://192.168.0.20/video.cgi'
#stream_addr = 'admin@http://192.168.0.20/video.cgi?.mjpg'
#stream_addr = '192.168.0.20/mjpeg.cgi'
img_addr = 'http://192.168.0.20/image/jpeg.cgi'
cap = cv2.VideoCapture(stream_addr)

cap = cv2.VideoCapture(0)

cv2.namedWindow('frame',cv2.WINDOW_NORMAL)

while(cap.isOpened()):
    t=time.time()
    # Read next frame
    ret, frame = cap.read()
    
    if not ret:
        break        
    
    # Show the frame
    cv2.imshow('frame', frame)
    
    print(frame.shape)
    print(1 / (time.time()-t),'Hz')
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
    
#VidOut.release()