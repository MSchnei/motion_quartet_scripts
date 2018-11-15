# -*- coding: utf-8 -*-
"""
Created on Wed Mar  1 12:50:02 2017

@author: marian
"""

import os

drt = '/media/sf_D_DRIVE/MotionQuartet/Data/P01/Session01/sortedDicoms'

lst = [name for name in os.listdir(drt) if os.path.isdir(os.path.join(drt,
       name))]

for strFolder in lst:
    print "\"" + strFolder + "\","
