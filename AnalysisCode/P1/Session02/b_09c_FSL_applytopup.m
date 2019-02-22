% Applytopup wrapper.

clc; clear all;

% set parenth path
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P1';

epiNames{1}=fullfile(dp,'P01_Exp2_Run3','P01_Exp2_Run3_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');
epiNames{2}=fullfile(dp,'P01_Exp3_Run3','P01_Exp3_Run3_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');
epiNames{3}=fullfile(dp,'P01_Exp2_Run4','P01_Exp2_Run4_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');
epiNames{4}=fullfile(dp,'P01_Exp3_Run4','P01_Exp3_Run4_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');
epiNames{5}=fullfile(dp,'P01_Exp2_Run5','P01_Exp2_Run5_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');
epiNames{6}=fullfile(dp,'P01_Exp3_Run5','P01_Exp3_Run5_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c_TRF.fmr');

%% Load fmr experiment time series, convert to nii
nrEpis=length(epiNames);
disp('Converting to nifti...')
for i=1:nrEpis;
    epi{i}=xff(epiNames{i});
    epi{i}.Write4DNifti([epiNames{i}(1:end-4),'.nii']);
    epi{i}.ClearObject;
    disp([num2str(i) '/' num2str(nrEpis) ' is converted.']);
end;

%% Apply topup
cwd = pwd;
cd(fullfile(dp,'TU/'))
for i=1:nrEpis;
    disp('Changing NaNs to zeros...');
    unix(['fsl5.0-fslmaths ', [epiNames{i}(1:end-4),'.nii '], '-nan ',...
         [epiNames{i}(1:end-4),'.nii.gz ']]);
    unix(['rm ',[epiNames{i}(1:end-4),'.nii ']]);
    disp('Applying topup...');
    unix(['fsl5.0-applytopup -i ',[epiNames{i}(1:end-4),'.nii.gz '],...
          '-a /media/sf_D_DRIVE/MotionQuartet/Tools/P1/Session01/b_10_TU/acqparams_unwarp_readout.txt ',...
          '--topup=/media/sf_D_DRIVE/MotionQuartet/Tools/P1/Session01/b_10_TU/P01_topup_results_Session01_readout ',...
          '--inindex=1 ',...
          '--method=jac ',...
          '--interp=spline ',...
          '--out=',[epiNames{i}(1:end-4),'_corrected.nii.gz '],...
          ]);

    unix(['gunzip ',[epiNames{i}(1:end-4),'_corrected.nii.gz']]);
    unix(['rm -rf ',[epiNames{i}(1:end-4),'_corrected.nii.gz']]);
    tempNii=xff([epiNames{i}(1:end-4),'_corrected.nii']);

    % Convert back to .fmr
    tempFmr=tempNii.Dyn3DToFMR;
    fmrProp=xff(epiNames{i});

    % Position information
    fmrProp.Slice.STCData=tempFmr.Slice.STCData;

    % Save with 'TU' suffix
    fmrProp.SaveAs([epiNames{i}(1:end-8),'_TU.fmr']);
    unix(['rm -rf ',[epiNames{i}(1:end-4),'_corrected.nii']]);
    unix(['rm -rf ',[epiNames{i}(1:end-4),'.nii.gz']]);
    disp([num2str(i) '/' num2str(nrEpis) ' is computed.']);

    % Delete xff objects
    tempFmr.ClearObject;
    tempNii.ClearObject;
    fmrProp.ClearObject;

end;
disp('Done.')
cd(cwd);
