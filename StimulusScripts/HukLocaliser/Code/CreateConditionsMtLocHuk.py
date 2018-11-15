# -*- coding: utf-8 -*-

"""Prepare condition order, targets and noise texture for stim presentation."""

from __future__ import division  # so that 1/3=0.333 instead of 1/3=0
import numpy as np
import os

# %% set parameters
NumOfCond = 3  # Number of different conditions
NumRepCond = 12  # Number of repetitions per condition per run
StimDur = 4  # Dur moving dots
IsiDur = np.array([6, 8, 10])  # jitter Dur ISI
FixDur = 12  # Dur fixation in beginning and end
NrOfTargets = 20  # Number of targets


# %% define conditions
conditions = []
for ind in range(0, NumRepCond):
    CondOrder = np.arange(1, NumOfCond+1)
    np.random.shuffle(CondOrder)
    BaseOrder = np.zeros(NumOfCond, dtype=np.int)
    block_elem = np.insert(BaseOrder, np.arange(len(CondOrder)), CondOrder)
    conditions = np.hstack((conditions, block_elem))

# add -1 in beginning and end
conditions = np.hstack(([-1], conditions, [-1]))
# make sure array is int
conditions = conditions.astype(int)


# %% define durations of stimulus and rest
durations = np.ones(len(conditions), dtype=np.int)*StimDur
# tile IsiDur so it matches the NumRepCond
if NumRepCond % len(IsiDur) != 0:
    print('WARNING: NumRepCond not exact multiples of IsiDur')
IsiDur = np.tile(IsiDur, NumRepCond/len(IsiDur))

for ind in CondOrder:
    Pos = np.where(conditions == ind)[0]+1
    np.random.shuffle(IsiDur)
    durations[Pos] = IsiDur
Pos = np.where(conditions == -1)
durations[Pos] = FixDur  # Dur fixation


# %% define the target onsets

# prepare random target positions
lgcRep = True
# switch to avoid repetitions
while lgcRep:
    targets = np.random.choice(np.arange(FixDur, np.sum(durations)-FixDur),
                               NrOfTargets, replace=False)
    # check that two targets do not follow each other immediately
    lgcRep = np.greater(np.sum(np.diff(np.sort(targets)) == 4), 0)
targets = np.sort(targets)

# prepare random target onset delay
targets = targets + np.random.uniform(0, 1, size=NrOfTargets)


# %% save the results

str_path_parent_up = os.path.abspath(
    os.path.join(os.path.dirname(__file__), '..'))
filename = os.path.join(str_path_parent_up, 'Conditions',
                        'MtLoc_Huk_run04')

np.savez(filename, conditions=conditions, durations=durations, targets=targets)
