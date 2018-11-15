# -*- coding: utf-8 -*-

"""Prepare condition order, targets and noise texture for stim presentation."""

from __future__ import division  # so that 1/3=0.333 instead of 1/3=0
import numpy as np
import os

# %% set parameters
# specify TR
TR = 2.0

# set number of repetitions per condition per block
numRepCond = 6

# set durations of moving dot condition
durMot = 6
# set durations of baseline (jitter inter-stimulus interval)
durIsi = np.array([8, 10, 12])
# set duration of fixation in beginning and end
durFix = 2

# set target length
targetDur = 0.3  # in s
# set number of targets
nrOfTargets = 30

# set directions
Directions = np.array([0, 90, 180, 270], dtype=np.int32)

# %% Create dictionary of parameters
dictParams = {}
dictParams['TR'] = TR
dictParams['numRepCond'] = numRepCond
dictParams['durMot'] = durMot
dictParams['durIsi'] = durIsi
dictParams['durFix'] = durFix
dictParams['targetDur'] = targetDur
dictParams['nrOfTargets'] = nrOfTargets
dictParams['Directions'] = Directions

# %% define conditions
Conditions = []
for ind in range(0, numRepCond):
    CondOrder = np.arange(1, len(Directions)+1)
    np.random.shuffle(CondOrder)
    BaseOrder = np.zeros(len(Directions), dtype=np.int)

    block_elem = np.insert(BaseOrder, np.arange(len(CondOrder)), CondOrder)
    # results in block_elem = [1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]
    Conditions = np.hstack((Conditions, block_elem))

# add -1 in beginning, middle and end
insrtInd = np.linspace(0, len(Conditions), 4, endpoint=True).astype(np.int32)
Conditions = np.insert(Conditions, insrtInd, [-1])
Conditions = Conditions.astype(np.int32)

# %% define durations of stimulus and rest
Durations = np.ones(len(Conditions), dtype=np.int32)*durMot
for ind in CondOrder:
    Pos = np.where(Conditions == ind)[0]+1
    durIsiElem = np.tile(durIsi, int(np.divide(len(Pos), len(durIsi))))
    np.random.shuffle(durIsiElem)
    Durations[Pos] = durIsiElem
Pos = np.where(Conditions == -1)
Durations[Pos] = durFix  # Dur fixation

Durations = Durations.astype(np.int32)

# %% define the target onsets

# prepare random target positions
lgcRep = True
# switch to avoid repetitions
while lgcRep:
    Targets = np.random.choice(np.arange(durFix, np.sum(Durations)-durFix),
                               nrOfTargets, replace=False)
    # check that two Targets do not follow each other immediately
    lgcRep = np.greater(np.sum(np.diff(np.sort(Targets)) <= TR), 0)
Targets = np.sort(Targets)

# prepare random target onset delay
Targets = Targets + np.random.uniform(0, 1, size=nrOfTargets) * TR


# %% save the results

str_path_parent_up = os.path.abspath(
    os.path.join(os.path.dirname(__file__), '..'))
filename = os.path.join(str_path_parent_up, 'Conditions',
                        'RndDotMot_run01')

np.savez(filename, Conditions=Conditions, Durations=Durations, Targets=Targets,
         dictParams=dictParams)
