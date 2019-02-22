%% this script converts from BrainVoyager *.fmr format to nii files
% requires neuroelf v0.9d

clear; clc; close all;

% set path with nii files
PathIn = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P9';
PathOut = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P9';

% set fmr names
components = {...
'P09_Exp2_Run4/P09_Exp2_Run4_SCSTBL', ...
'P09_Exp3_Run4/P09_Exp3_Run4_SCSTBL', ...
'P09_Exp2_Run5/P09_Exp2_Run5_SCSTBL', ...
'P09_Exp3_Run5/P09_Exp3_Run5_SCSTBL', ...
'P09_Exp2_Run6/P09_Exp2_Run6_SCSTBL', ...
'P09_Exp3_Run6/P09_Exp3_Run6_SCSTBL', ...
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
