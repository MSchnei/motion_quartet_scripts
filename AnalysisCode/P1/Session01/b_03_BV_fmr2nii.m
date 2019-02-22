%% this script converts from BrainVoyager *.fmr format to nii files
% requires neuroelf v0.9d

clear; clc; close all;

% set path with nii files
PathIn = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P1';
PathOut = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P1';

% set fmr names
components = {...
'P01_Exp1_Run1/P01_Exp1_Run1_SCSTBL', ...
'P01_Exp1_Run2/P01_Exp1_Run2_SCSTBL', ...
'P01_Exp1_Run3/P01_Exp1_Run3_SCSTBL', ...
'P01_Exp2_Run1/P01_Exp2_Run1_SCSTBL', ...
'P01_Exp2_Run2/P01_Exp2_Run2_SCSTBL', ...
'P01_Exp3_Run1/P01_Exp3_Run1_SCSTBL', ...
'P01_Exp3_Run2/P01_Exp3_Run2_SCSTBL', ...
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
