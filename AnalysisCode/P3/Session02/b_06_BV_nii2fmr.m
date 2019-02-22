%% this script converts from nii files back to BrainVoyager *.fmr
% requires neuroelf v0.9d

clear; clc; close all;

% set prependix for motion corrected images
prepMotCor = 'nrw';

% set path with nii files
PathIn = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P3';
PathOut = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P3';

% set fmr names
components = {...
'P03_Exp2_Run3/nrwP03_Exp2_Run3_SCSTBL',...
'P03_Exp3_Run4/nrwP03_Exp3_Run4_SCSTBL',...
'P03_Exp2_Run4/nrwP03_Exp2_Run4_SCSTBL',...
'P03_Exp3_Run5/nrwP03_Exp3_Run5_SCSTBL',...
'P03_Exp2_Run5/nrwP03_Exp2_Run5_SCSTBL',...
'P03_Exp3_Run6/nrwP03_Exp3_Run6_SCSTBL',...
};

% define number of runs
nr_fmrs = length(components);

% deduce motion corrected *.nii names
for i=1:nr_fmrs
  nii_names{i}=fullfile(PathIn,[components{i},'.nii']);
end

% deduce name of original nii files
for i = 1:nr_fmrs
  [filepath,name,ext] = fileparts(nii_names{i});
	fmr_names{i}=fullfile(filepath, [name(1+length(prepMotCor):end),'.fmr']);
end

% convert nii to fmr
for i=1:nr_fmrs;
    % create temporary nii
    tempnii=xff(nii_names{i});
    % Convert .nii back to .fmr
    tempfmr=tempnii.Dyn3DToFMR;
    fmr_prop=xff(fmr_names{i});
    % Position information
    fmr_prop.Slice.STCData=tempfmr.Slice.STCData;
    % Save
    [pathstrnii,niiname,~] = fileparts(nii_names{i});
    fmr_prop.SaveAs([pathstrnii,'/',niiname(length(prepMotCor)+1:end),'_MotCorSPM_nrw','.fmr']);
    disp([pathstrnii,'/',niiname(length(prepMotCor)+1:end),'_MotCorSPM_nrw','.fmr',' ','created'])
end
