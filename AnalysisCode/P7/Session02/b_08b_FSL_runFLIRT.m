% FSL FLIRT wrapper for BV.

clc; clear all;
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P7';
cd(dp)
% reference and input '.fmr'
refImaFileName = fullfile(dp,'P07_Exp3_Run1','meanP07_Exp3_Run1_SCSTBL.nii');
inpImaFileName = fullfile(dp,'P07_Exp2_Run3','meanP07_Exp2_Run3_SCSTBL.nii');

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
