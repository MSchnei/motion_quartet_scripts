% FSL applytopup wrapper for BV.

clc; clear all;

% set parenth path
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P3';

epiNames{1}=fullfile(dp,'P03_Exp3_Run1','P03_Exp3_Run1_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{2}=fullfile(dp,'P03_Exp2_Run1','P03_Exp2_Run1_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{3}=fullfile(dp,'P03_Exp3_Run2','P03_Exp3_Run2_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{4}=fullfile(dp,'P03_Exp2_Run2','P03_Exp2_Run2_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{5}=fullfile(dp,'P03_Exp3_Run3','P03_Exp3_Run3_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{6}=fullfile(dp,'P03_Exp1_Run1','P03_Exp1_Run1_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{7}=fullfile(dp,'P03_Exp1_Run2','P03_Exp1_Run2_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{8}=fullfile(dp,'P03_Exp1_Run3','P03_Exp1_Run3_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');

%% Load fmr experiment time series, convert to nii
disp('Convert to nii...')
nr_epis=length(epiNames);
for ind=1:nr_epis;
    disp(['...Converting run ', num2str(ind), ' of ', num2str(nr_epis)])
    epi{ind}=xff(epiNames{ind});
    epi{ind}.Write4DNifti([epiNames{ind}(1:end-4),'.nii']);
    epi{ind}.ClearObject;
end;

%% Apply topup
for ind=1:nr_epis;
    disp(['Process run ', num2str(ind), ' of ', num2str(nr_epis)]);

    disp('...Changing NaNs to zeros...');
    unix(['fsl5.0-fslmaths ', [epiNames{ind}(1:end-4),'.nii '], '-nan ',...
         [epiNames{ind}(1:end-4),'.nii.gz ']]);
    unix(['rm -rf ',[epiNames{ind}(1:end-4),'.nii']]);

    disp('...Applying topup...');
    unix(['fsl5.0-applytopup -i ',...
         [epiNames{ind}(1:end-4),'.nii.gz '],...
         '-a acqparams_unwarp_readout.txt ',...
         '--topup=P03_topup_results_Session01_readout ',...
         '--inindex=1 ',...
         '--method=jac ',...
         '--interp=spline ',...
         ['--out=',epiNames{ind}(1:end-4),'_corrected.nii.gz']]);
    unix(['gunzip ',[epiNames{ind}(1:end-4),'_corrected.nii.gz']]);
    unix(['rm -rf ',[epiNames{ind}(1:end-4),'_corrected.nii.gz']]);

    disp('...Converting to fmr...');
    tempNii=xff([epiNames{ind}(1:end-4),'_corrected.nii']);
    % Convert back to .fmr
    tempFmr=tempNii.Dyn3DToFMR;
    fmrProp=xff(epiNames{ind});
    % Position information
    fmrProp.Slice.STCData=tempFmr.Slice.STCData;
    % Save
    fmrProp.SaveAs([epiNames{ind}(1:end-4),'_TU.fmr']);
    unix(['rm -rf ',[epiNames{ind}(1:end-4),'_corrected.nii']]);
    unix(['rm -rf ',[epiNames{ind}(1:end-4),'.nii.gz']]);
    disp(['...fmr ' num2str(ind) ' of ' num2str(nr_epis) ' computed']);

    % Delete xff objects
    tempFmr.ClearObject;
    tempNii.ClearObject;
    fmrProp.ClearObject;
end;
