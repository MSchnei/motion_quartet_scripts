# -*- coding: utf-8 -*-
"""
Created on Mon Jul 20 16:47:28 2015

@author: Marian.Schneider
"""

from __future__ import division  # so that 1/3=0.333 instead of 1/3=0
from psychopy import visual, event, core, monitors, logging, gui, data, misc
import numpy as np
import os

# %% Set parameters

# set dimensions of the aperture square
dimX = 5.2
dimY = 5.2

# set subject specific distances
horiDist = 3.0
vertiDist = 3.8

# specificy background color
backColor = [-0.5, -0.5, -0.5]  # from -1 (black) to 1 (white)
# specificy dot color
dotColor = np.multiply(backColor, -1)  # from -1 (black) to 1 (white)

# set the number of dots
nDots = 250
# specify speed in units per frame
dotSpeed1 = 8  # deg/s
dotSpeed2 = 8  # deg/s
# set dot Life, how long should a dot life
dotLife = 120  # number of frames [6]
# set size of the dots [diameter]
dotSize = 0.2  # in deg


# %%  SAVING and LOGGING
# Store info about experiment and experimental run
expName = 'RndDotMot_fullfield'  # set experiment name here
expInfo = {
    u'run': u'01',
    u'participant': u'pilot',
    }

# Create GUI at the beginning of exp to get more expInfo
dlg = gui.DlgFromDict(dictionary=expInfo, title=expName)
if dlg.OK == False: core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName

# get current path and save to variable _thisDir
_thisDir = os.path.dirname(os.path.abspath(__file__))
# get parent path and move up one directory
str_path_parent_up = os.path.abspath(
    os.path.join(os.path.dirname( __file__ ), '..'))

# Name and create specific subject folder
subjFolderName = str_path_parent_up + os.path.sep + '%s_SubjData' % (
    expInfo['participant'])
if not os.path.isdir(subjFolderName):
    os.makedirs(subjFolderName)
# Name and create specific folder for logging results
logFolderName = subjFolderName + os.path.sep + 'Logging'
if not os.path.isdir(logFolderName):
    os.makedirs(logFolderName)
logFileName = logFolderName + os.path.sep + '%s_%s_Run%s_%s' % (
    expInfo['participant'], expInfo['expName'], expInfo['run'],
    expInfo['date'])
# Name and create specific folder for pickle output
outFolderName = subjFolderName + os.path.sep + 'Pickle'
if not os.path.isdir(outFolderName):
    os.makedirs(outFolderName)
outFileName = outFolderName + os.path.sep + '%s_%s_Run%s_%s' % (
    expInfo['participant'], expInfo['expName'], expInfo['run'],
    expInfo['date'])
# Name and create specific folder for BV protocol files
prtFolderName = subjFolderName + os.path.sep + 'Protocols'
if not os.path.isdir(prtFolderName):
    os.makedirs(prtFolderName)

# save a log file and set level for msg to be received
logFile = logging.LogFile(logFileName+'.log', level=logging.INFO)
logging.console.setLevel(logging.WARNING)  # set console to receive warnings

# log parameters that were set by user
logFile.write('nDots=' + unicode(nDots) + '\n')
logFile.write('dotSpeed1=' + unicode(dotSpeed1) + '\n')
logFile.write('dotSpeed2=' + unicode(dotSpeed2) + '\n')
logFile.write('dotLife=' + unicode(dotLife) + '\n')
logFile.write('dotSize=' + unicode(dotSize) + '\n')
logFile.write('backColor=' + unicode(backColor) + '\n')
logFile.write('dotColor=' + unicode(dotColor) + '\n')

# %% MONITOR AND WINDOW

# set monitor information:
distanceMon = 99  # [58] in psychoph lab [99] in scanner
widthMon = 30  # [53] in psychoph lab [30] in scanner
PixW = 1920.0  # [1920.0] in psychopy lab [1920.0] in scanner
PixH = 1200.0  # [1080.0] in psychoph lab [1200.0] in psychoph lab

moni = monitors.Monitor('testMonitor', width=widthMon, distance=distanceMon)
moni.setSizePix([PixW, PixH])  # [1920.0, 1080.0] in psychoph lab

# log monitor info
logFile.write('MonitorDistance=' + unicode(distanceMon) + 'cm' + '\n')
logFile.write('MonitorWidth=' + unicode(widthMon) + 'cm' + '\n')
logFile.write('PixelWidth=' + unicode(PixW) + '\n')
logFile.write('PixelHeight=' + unicode(PixH) + '\n')

# set screen:
myWin = visual.Window(size=(PixW, PixH),
                      screen = 0,
                      winType='pyglet',  # winType : None, ‘pyglet’, ‘pygame’
                      allowGUI=False,
                      allowStencil=True,
                      fullscr=True,  # for psychoph lab: fullscr = True
                      monitor=moni,
                      color=backColor,
                      colorSpace='rgb',
                      units='deg',
                      blendMode='avg',
                      )

# %% CONDITIONS, DURATIONS, TARGETS

# Load enpz file containing conditions, durations, and targets
filename = os.path.join(str_path_parent_up, 'Conditions',
                        'RndDotMot_run' + str(expInfo['run']) + '.npz')
npzfile = np.load(filename)

# load conditions
Conditions = npzfile['Conditions']
logFile.write('Conditions=' + unicode(Conditions) + '\n')

# load durations of stimulus and rest
Durations = npzfile['Durations']
logFile.write('Durations=' + unicode(Durations) + '\n')

# load the target onsets
Targets = npzfile['Targets']
logFile.write('Targets=' + unicode(Targets) + '\n')

# load dictionary with parameters
dictParams = npzfile['dictParams'].tolist()

# load TR
TR = dictParams['TR']
# load number of repetitions per condition per block
numRepCond = dictParams['numRepCond']
# load durations of moving dot condition
durMot = dictParams['durMot']
# load durations of baseline (jitter inter-stimulus interval)
durIsi = dictParams['durIsi']
# load duration of fixation in beginning and end
durFix = dictParams['durFix']
# load target length
targetDur = dictParams['targetDur']
# load number of targets
nrOfTargets = dictParams['nrOfTargets']
# load directions
Directions = dictParams['Directions']

logFile.write('numRepCond=' + unicode(numRepCond) + '\n')
logFile.write('durMot=' + unicode(durMot) + '\n')
logFile.write('durIsi=' + unicode(durIsi) + '\n')
logFile.write('durFix=' + unicode(durFix) + '\n')
logFile.write('targetDur=' + unicode(targetDur) + '\n')
logFile.write('nrOfTargets=' + unicode(nrOfTargets) + '\n')
logFile.write('Directions=' + unicode(Directions) + '\n')
logFile.write('TR=' + unicode(TR) + '\n')


# %% TIME AND TIMING PARAMETERS

# get screen refresh rate
refr_rate = myWin.getActualFrameRate()  # get screen refresh rate
if refr_rate is not None:
    frameDur = 1.0/round(refr_rate)
else:
    frameDur = 1.0/60.0  # couldn't get a reliable measure so guess
logFile.write('RefreshRate=' + unicode(refr_rate) + '\n')
logFile.write('FrameDuration=' + unicode(frameDur) + '\n')

# update the dotSpeed with the refresh rate
dotSpeed1 = dotSpeed1 / refr_rate
dotSpeed2 = dotSpeed2 / refr_rate

# derive number of frames that target will last
nrOfTargetFrames = int(targetDur/frameDur)

# create clock
clock = core.Clock()
logging.setDefaultClock(clock)


# %% STIMULI
squareSize = 1.0
rectStim = visual.Rect(
    myWin,
    width=2*horiDist-squareSize,
    height=2*vertiDist-squareSize,
    autoLog=False,
    name='rectStim',
    units='deg',
    fillColor=backColor,
    lineColor=backColor,
    )

dotPatch = visual.ElementArrayStim(
    myWin,
    autoLog=False,
    elementTex=None,
    name='dotPatch',
    elementMask='circle',
    nElements=int(nDots),
    sizes=dotSize,
    units='deg',
    colors=dotColor,
    xys=None,
    fieldShape='square',
    fieldSize=(dimX*2, dimY*2),
    interpolate=True,
    )

# fixation dot
dotFix = visual.Circle(
    myWin,
    autoLog=False,
    name='dotFix',
    units='deg',
    radius=0.075,
    fillColor=[1.0, 0.0, 0.0],
    lineColor=[1.0, 0.0, 0.0],
    )

dotFixSurround = visual.Circle(
    myWin,
    autoLog=False,
    name='dotFix',
    units='deg',
    radius=0.15,
    fillColor=[0.5, 0.5, 0.0],
    lineColor=[0.0, 0.0, 0.0],
    )

# control text
controlText = visual.TextStim(
    win=myWin,
    colorSpace='rgb',
    color=[1.0, 1.0, 1.0],
    height=0.5,
    pos=(0.0, -4.0),
    autoLog=False,
    )

# control text
controlText = visual.TextStim(
    win=myWin,
    colorSpace='rgb',
    color=[1.0, 1.0, 1.0],
    height=0.5,
    pos=(0.0, -4.0),
    autoLog=False,
    )

# text at the beginning of the experiment
triggerText = visual.TextStim(
    win=myWin,
    colorSpace='rgb',
    color=[1.0, 1.0, 1.0],
    height=0.5,
    text='Experiment will start soon. Waiting for scanner'
    )


# %% FUNCTIONS

def dots_init_square(nDots):
    """Determine initial dot positions in square."""
    dotsX = np.random.uniform(-dimX, dimX, size=nDots)
    dotsY = np.random.uniform(-dimY, dimY, size=nDots)
    # create array frameCount
    frameCount = np.random.uniform(0, dotLife,
                                   size=len(dotsX)).astype(np.int32)

    return dotsX, dotsY, frameCount


def dots_update_square(dotsX, dotsY, dimX, dimY, motDir, frameCount, dotSpeed,
                       frameDeathAfter=np.inf):
    """Update dot positions in square"""

    # update radius using cartesian coordinates
    dotsX += np.cos(motDir*(np.pi/180))*dotSpeed
    dotsY += np.sin(motDir*(np.pi/180))*dotSpeed

    # find dots that fell out of field
    lgcOutMinX = (dotsX < -dimX)
    dotsX[lgcOutMinX] = np.copy(dotsX[lgcOutMinX] % dimX)
    lgcOutMaxX = (dotsX > dimX)
    dotsX[lgcOutMaxX] = np.subtract(dotsX[lgcOutMaxX] % dimX, dimX)

    lgcOutMinY = (dotsY < -dimY)
    dotsY[lgcOutMinY] = np.copy(dotsY[lgcOutMinY] % dimY)
    lgcOutMaxY = (dotsY > dimY)
    dotsY[lgcOutMaxY] = np.subtract(dotsY[lgcOutMaxY] % dimY, dimY)

    # create logical for where frameCount too high
    lgcFrameDeath = (frameCount >= frameDeathAfter)
    # replace radius and angle for those dots that died due to frameCount
    dotsX[lgcFrameDeath] = np.random.uniform(-dimX, dimX,
                                             size=np.sum(lgcFrameDeath))
    dotsY[lgcFrameDeath] = np.random.uniform(-dimY, dimY,
                                             size=np.sum(lgcFrameDeath))

    # increase frameCount for every elements
    frameCount += 1
    # set the counter for newborn dots to zero
    frameCount[lgcFrameDeath] = 0

    return dotsX, dotsY, frameCount


def target(mtargetCounter):
    """Determine if target should be drawn."""

    tat = clock.getTime()
    # first time in target interval? reset target counter to 0!
    if sum(tat >= Targets) + sum(tat < Targets + frameDur) == len(Targets) + 1:
        mtargetCounter = 0
    # below number of target frames? display target!
    if mtargetCounter < nrOfTargetFrames:
        # change color fix dot surround to red
        dotFixSurround.fillColor = [0.5, 0.0, 0.0]
        dotFixSurround.lineColor = [0.5, 0.0, 0.0]
    # above number of target frames? dont display target!
    else:
        # keep color fix dot surround yellow
        dotFixSurround.fillColor = [0.5, 0.5, 0.0]
        dotFixSurround.lineColor = [0.5, 0.5, 0.0]

    # update mtargetCounter
    mtargetCounter = mtargetCounter + 1

    return mtargetCounter


# %% RENDER_LOOP

# Create Counters
i = 0  # counter for blocks

# draw dots for the first time
dotsX, dotsY, frameCntsIn = dots_init_square(nDots)
# set x and y positions to initialized values
dotPatch.setXYs(np.array([dotsX, dotsY]).transpose())

# define DirTime and calculate AxisTime
DirTime = 1.0  # move in one dir before moving in opposite
AxisTime = DirTime*2  # because we have 2 dir states (back and forth)

# create array to log key pressed events
TimeKeyPressedArray = np.array([], dtype=float)

# set initial value for target counter
mtargetCounter = nrOfTargetFrames+1

# parameters
totalTime = np.sum(Durations)

# give the system time to settle
core.wait(1)

# wait for scanner trigger
triggerText.draw()
myWin.flip()
event.waitKeys(keyList=['5'], timeStamped=False)

# reset clocks
clock.reset()
logging.data('StartOfRun' + unicode(expInfo['run']))

while clock.getTime() < totalTime:

    # low-level rest (only central fixation dot)
    if Conditions[i] == -1:
        # initialize frame counts, just in case dotLife was inifnite before
        frameCntsIn = np.random.uniform(0, dotLife,
                                        size=nDots).astype(np.int32)
        # set loopDotSpeed to zero
        loopDotSpeed = 0
        # set loopDotLife to inf
        loopDotLife = np.inf
        # set opacities
        dotPatch.opacities = 0
        # set contrast
        dotPatch.colors = dotColor

    # static dots rest
    elif Conditions[i] == 0:
        # initialize frame counts, just in case dotLife was inifnite before
        frameCntsIn = np.random.uniform(0, dotLife,
                                        size=nDots).astype(np.int32)
        # set loopDotSpeed to zero
        loopDotSpeed = 0
        # set loopDotLife to inf
        loopDotLife = dotLife
        # set opacity to 1 for all static
        dotPatch.opacities = 1.0
        # set contrast
        dotPatch.colors = dotColor

    # horizontal motion
    elif Conditions[i] in [1, 3]:
        # initialize frame counts, just in case dotLife was inifnite before
        frameCntsIn = np.random.uniform(0, dotLife,
                                        size=nDots).astype(np.int32)
        # set loopDotSpeed to dotSpeed
        loopDotSpeed = dotSpeed1
        # set loopDotLife to dotLife
        loopDotLife = dotLife
        # set opacaities
        dotPatch.opacities = 1
        # set contrast
        dotPatch.colors = dotColor

    # vertical motion
    elif Conditions[i] in [2, 4]:
        # initialize frame counts, just in case dotLife was inifnite before
        frameCntsIn = np.random.uniform(0, dotLife,
                                        size=nDots).astype(np.int32)
        # set loopDotSpeed to dotSpeed
        loopDotSpeed = dotSpeed2
        # set loopDotLife to dotLife
        loopDotLife = dotLife
        # set opacaities
        dotPatch.opacities = 1
        # set contrast
        dotPatch.colors = dotColor

    while clock.getTime() < np.sum(Durations[0:i+1]):

        t = clock.getTime()

        if t % AxisTime < DirTime:
            motDir = Directions[Conditions[i]-1]
            dotsX, dotsY, frameCntsIn = dots_update_square(
                dotsX, dotsY, dimX, dimY, motDir, frameCntsIn,
                loopDotSpeed,
                frameDeathAfter=loopDotLife)

        elif t % AxisTime >= DirTime and t % AxisTime < 2*DirTime:
            motDir = Directions[Conditions[i]-1]
            dotsX, dotsY, frameCntsIn = dots_update_square(
                dotsX, dotsY, dimX, dimY, motDir, frameCntsIn,
                -loopDotSpeed,
                frameDeathAfter=loopDotLife)

        # update and draw
        dotPatch.setXYs(np.array([dotsX, dotsY]).transpose())

        dotPatch.draw()

        # update target
        mtargetCounter = target(mtargetCounter)

#        # draw control text
#        controlText.setText(clock.getTime())
#        controlText.draw()

        # draw fixation point surround
        dotFixSurround.draw()

        # draw fixation point
        dotFix.draw()

        # flip window
        myWin.flip()

        # handle key presses each frame
        for keys in event.getKeys():
            if keys[0] in ['escape', 'q']:
                myWin.close()
                core.quit()
            elif keys in ['1']:
                TimeKeyPressedArray = np.append([TimeKeyPressedArray],
                                                [clock.getTime()])
                logging.data(msg='Key1 pressed')

    i = i+1

logging.data('EndOfRun' + unicode(expInfo['run']) + '\n')


# %%  TARGET DETECTION RESULTS
# calculate target detection results
# create an array 'targetDetected' for showing which targets were detected
targetDetected = np.zeros(len(Targets))
if len(TimeKeyPressedArray) == 0:
    # if no buttons were pressed
    print("No keys were pressed/registered")
    targetsDet = 0
else:
    # if buttons were pressed:
    for index, target in enumerate(Targets):
        for TimeKeyPress in TimeKeyPressedArray:
            if (float(TimeKeyPress) >= float(target) and
                    float(TimeKeyPress) <= float(target)+2):
                targetDetected[index] = 1

logging.data('ArrayOfDetectedTargets' + unicode(targetDetected))
print('Array Of Detected Targets:')
print(targetDetected)

# number of detected targets
targetsDet = sum(targetDetected)
logging.data('NumberOfDetectedTargets' + unicode(targetsDet))
# detection ratio
DetectRatio = targetsDet/len(targetDetected)
logging.data('RatioOfDetectedTargets' + unicode(DetectRatio))

# display target detection results to participant
resultText = 'You have detected %i out of %i targets.' % (targetsDet,
                                                          len(Targets))
print(resultText)
logging.data(resultText)
# also display a motivational slogan
if DetectRatio >= 0.95:
    feedbackText = 'Excellent! Keep up the good work'
elif DetectRatio < 0.95 and DetectRatio >= 0.85:
    feedbackText = 'Well done! Keep up the good work'
elif DetectRatio < 0.85 and DetectRatio >= 0.65:
    feedbackText = 'Please try to focus more'
else:
    feedbackText = 'You really need to focus more!'

targetText = visual.TextStim(
    win=myWin,
    color='white',
    height=0.5,
    pos=(0.0, 0.0),
    autoLog=False,
    )

targetText.setText(resultText + '\n' + feedbackText)
logFile.write(unicode(resultText) + '\n')
logFile.write(unicode(feedbackText) + '\n')
targetText.draw()
myWin.flip()
core.wait(5)
myWin.close()


# %% SAVE DATA
try:
    # create python dictionary
    output = {'ExperimentName': expInfo['expName'],
              'Date': expInfo['date'],
              'SubjectID': expInfo['participant'],
              'Run_Number': expInfo['run'],
              'Conditions': Conditions,
              'Durations': Durations,
              'KeyPresses': TimeKeyPressedArray,
              'DetectedTargets': targetDetected,
              }
    # save dictionary as a pickle in outpu folder
    misc.toFile(outFileName + '.pickle', output)
    print('Output Data saved as: ' + outFileName + '.pickle')
    print("***")
except:
    print('(OUTPUT folder could not be created.)')

# create prt files for BV
try:
    os.chdir(prtFolderName)

    # Convert durations from s to volumes
    DurationsVol = (Durations/float(TR))
    DurationsVol = DurationsVol.astype(np.int32)

    TargetsVol = (Targets/float(TR))
    TargetsVol = TargetsVol.astype(np.int32)

    # Group Conditions Horizontal1 and Horizontal2 together as well as group
    # Vertical1 and Vertical2 together
    Conditions[Conditions == 3] = 1
    Conditions[Conditions == 4] = 2

    # Set Conditions Names
    CondNames = ['Fixation',
                 'Flicker',
                 'Horizontal',
                 'Vertical']

    # Number code the conditions, i.e. Fixation = -1, Static = 0, etc.
    from collections import OrderedDict
    stimTypeDict = OrderedDict()
    stimTypeDict[CondNames[0]] = [-1]
    stimTypeDict[CondNames[1]] = [0]
    stimTypeDict[CondNames[2]] = [1]
    stimTypeDict[CondNames[3]] = [2]

    # Color code the conditions
    colourTypeDict = {
        CondNames[0]: '64 64 64',
        CondNames[1]: '192 192 192',
        CondNames[2]: '255 0 0',
        CondNames[3]: '0 255 0',
        }

    # Defining a function will reduce the code length significantly.
    def idxAppend(iteration, enumeration, dictName, outDict):
        if int(enumeration) in range(stimTypeDict[dictName][0],
                                     stimTypeDict[dictName][-1]+1
                                     ):
            outDict = outDict.setdefault(dictName, [])
            outDict.append(iteration)

    # Reorganization of the protocol array (finding and saving the indices)
    outIdxDict = {}  # an empty dictionary

    # Please take a deeper breath.
    for i, j in enumerate(Conditions):
        for k in stimTypeDict:  # iterate through each key in dict
            idxAppend(i, j, k, outIdxDict)

    print(outIdxDict)

    # Creation of the Brainvoyager .prt custom text file
    prtName = '%s_%s_Run%s_%s.prt' % (expInfo['participant'],
                                      expInfo['expName'], expInfo['run'],
                                      expInfo['date'])

    file = open(prtName, 'w')
    header = ['FileVersion: 2\n',
              'ResolutionOfTime: Volumes\n',
              'Experiment: %s\n' % expName,
              'BackgroundColor: 0 0 0\n',
              'TextColor: 255 255 202\n',
              'TimeCourseColor: 255 255 255\n',
              'TimeCourseThick: 3\n',
              'ReferenceFuncColor: 192 192 192\n',
              'ReferenceFuncThick: 2\n'
              'NrOfConditions: %s\n' % str(len(stimTypeDict)+1)
              ]

    file.writelines(header)

    # Conditions/predictors
    for i in stimTypeDict:  # iterate through each key in stim. type dict
        h = i

        # Write the condition/predictor name and put the Nr. of repetitions
        file.writelines(['\n',
                         i+'\n',
                         str(len(outIdxDict[i]))
                         ])

        # iterate through each element, define onset and end of each condition
        for j in outIdxDict[i]:
            onset = int(sum(DurationsVol[0:j+1]) - DurationsVol[j] + 1)
            file.write('\n')
            file.write(str(onset))
            file.write(' ')
            file.write(str(onset + DurationsVol[j]-1))
        # contiditon color
        file.write('\nColor: %s\n' % colourTypeDict[h])

    # Write Targets
    file.writelines(['\n',
                     'Targets'+'\n',
                     str(len(TargetsVol))
                     ])
    for j in TargetsVol:
        file.write('\n')
        file.write(str(j))
        file.write(' ')
        file.write(str(j + 1))
    # contiditon color
    file.write('\nColor: 100 100 100\n')

    file.close()
    print('PRT files saved as: ' + prtFolderName + '\\' + prtName)
    os.chdir(_thisDir)
except:
    print('(PRT files could not be created.)')


# %% FINISH
core.quit()
