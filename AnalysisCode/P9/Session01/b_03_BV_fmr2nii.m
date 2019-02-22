%% this script converts from BrainVoyager *.fmr format to nii files
% requires neuroelf v0.9d

clear; clc; close all;

% set path with nii files
PathIn = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P9';
PathOut = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P9';

% set fmr names
components = {...
'P09_Exp2_Run1/P09_Exp2_Run1_SCSTBL', ...
'P09_Exp3_Run1/P09_Exp3_Run1_SCSTBL', ...
'P09_Exp2_Run2/P09_Exp2_Run2_SCSTBL', ...
'P09_Exp3_Run2/P09_Exp3_Run2_SCSTBL', ...
'P09_Exp3_Run3/P09_Exp3_Run3_SCSTBL', ...
'P09_Exp2_Run3/P09_Exp2_Run3_SCSTBL', ...
};

% define number of runs
nr_fmrs = length(components);

for ind = 1:nr_fmrs
	fmr_names{ind}=fullfile(PathIn,[components{1,ind},'.fmr']);
end

% deduce future *.nii names
for i=1:nr_fmrs
    nii_names{i}=fmr_names{i}(1:end-4);
end

% convert fmr to nii
for i=1:nr_fmrs
    temp_fmr = xff(fmr_names{i});
    temp_fmr.Write4DNifti(nii_names{i});
    temp_fmr.ClearObject;
    disp([nii_names{i},' ','created'])
end
