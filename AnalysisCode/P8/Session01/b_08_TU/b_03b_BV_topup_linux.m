% FSL topup wrapper for BV.

clc; clear all;
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P8/TU/Session01';

% Load AP and PA phase '.fmr'
phaseEncFilename_1 = fullfile(dp,'P08_para_SCSTBL_3DMCTS_LTR_THPGLMF2c_3DMCTS.fmr');
phaseEncFilename_2 = fullfile(dp,'P08_anti_SCSTBL_3DMCTS_LTR_THPGLMF2c_3DMAS.fmr');

%% Convert to nii
disp('Converting to nifti...')
phaseEnc1 = xff(phaseEncFilename_1);
phaseEnc1.Write4DNifti([phaseEncFilename_1(1:end-3),'nii']);
phaseEnc1.ClearObject;

phaseEnc2 = xff(phaseEncFilename_2);
phaseEnc2.Write4DNifti([phaseEncFilename_2(1:end-3),'nii']);
phaseEnc2.ClearObject;

%% Merge
disp('Merging files...')
unix(['fsl5.0-fslmerge -t P08_para_anti_merge ',...
     [phaseEncFilename_1(1:end-3),'nii '],...
     [phaseEncFilename_2(1:end-3),'nii']]);

%% Topup
disp('Topup is running...')
unix(['fsl5.0-topup --imain=P08_para_anti_merge ',...
      '--datain=acqparams_readout.txt ',...
      '--config=b0_MQ.cnf ',...
      '--out=P08_topup_results_Session01_readout ',...
      '--fout=P08_fieldmap_Session01_readout',...
      ]);
disp('top up computed')
