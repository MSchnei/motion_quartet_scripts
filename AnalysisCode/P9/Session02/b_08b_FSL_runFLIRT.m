% FSL FLIRT wrapper for BV.

clc; clear all;
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P9';
cd(dp)
% reference and input '.fmr'
refImaFileName = fullfile(dp,'P09_Exp2_Run1','meanP09_Exp2_Run1_SCSTBL.nii');
inpImaFileName = fullfile(dp,'P09_Exp2_Run4','meanP09_Exp2_Run4_SCSTBL.nii');

%% FLIRT
disp('Run FLIRT...')
unix(['fsl5.0-flirt ',...
      ['-in ', inpImaFileName,' '],...
      ['-ref ', refImaFileName,' '],...
      ['-out ',fullfile(dp,'FNIRT','FLIRT'),' '],...
      ['-omat ',fullfile(dp,'FNIRT','FLIRT.mat'),' '],...
      '-bins 256 -cost corratio ',...
      '-searchrx -90 90 -searchry -90 90 -searchrz -90 90 ',...
      '-dof 12 ',...
      ['-refweight ', refImaFileName(1:end-4),'_msk '],...
      ]);
disp('FLIRT computed')
