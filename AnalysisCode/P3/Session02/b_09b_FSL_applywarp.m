% Applywarp wrapper.

clc; clear all;

% set parenth path
dp = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P3';

epiNames{1}=fullfile(dp,'P03_Exp2_Run3','P03_Exp2_Run3_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{2}=fullfile(dp,'P03_Exp3_Run4','P03_Exp3_Run4_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{3}=fullfile(dp,'P03_Exp2_Run4','P03_Exp2_Run4_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{4}=fullfile(dp,'P03_Exp3_Run5','P03_Exp3_Run5_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{5}=fullfile(dp,'P03_Exp2_Run5','P03_Exp2_Run5_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');
epiNames{6}=fullfile(dp,'P03_Exp3_Run6','P03_Exp3_Run6_SCSTBL_MotCorSPM_nrw_LTR_THPGLMF5c.fmr');

% specify path to the reference image that was used for FNIRT
refIma = fullfile(dp,'P03_Exp3_Run1','meanP03_Exp3_Run1_SCSTBL');
% specify path to the outcome warp coefficients from FNIRT
wrpTrf = fullfile(dp,'FNIRT','P03_Exp2_Run3_TO_Exp3_Run1_nonlinear_transf');

%% Load fmr experiment time series, convert to nii
nrEpis=length(epiNames);
disp('Converting to nifti...')
for i=1:nrEpis
    epi{i}=xff(epiNames{i});
    epi{i}.Write4DNifti([epiNames{i}(1:end-4),'.nii']);
    epi{i}.ClearObject;
    disp([num2str(i) '/' num2str(nrEpis) ' is converted.']);
end;


%% applywarp
cwd = pwd;
cd(dp);
for i=1:nrEpis;
    disp('Changing NaNs to zeros...');
    unix(['fsl5.0-fslmaths ', [epiNames{i}(1:end-4),'.nii '], '-nan ',...
         [epiNames{i}(1:end-4),'.nii.gz ']]);
    unix(['rm -rf ',[epiNames{i}(1:end-4),'.nii ']]);
    disp('Apply warp...');
    unix(['applywarp ',...
          ['--ref=',refIma,' '],...
          ['--in=',[epiNames{i}(1:end-4),'.nii.gz ']],...
          ['--warp=',wrpTrf,' '],...
          '--interp=sinc ',...
          '--out=',[epiNames{i}(1:end-4),'_corrected.nii.gz '],...
          ]);

    unix(['gunzip ',[epiNames{i}(1:end-4),'_corrected.nii.gz']]);
    unix(['rm -rf ',[epiNames{i}(1:end-4),'_corrected.nii.gz']]);
    tempNii=xff([epiNames{i}(1:end-4),'_corrected.nii']);

    % Convert back to .fmr
    disp('Converting back to fmr...');
    tempFmr=tempNii.Dyn3DToFMR;
    fmrProp=xff(epiNames{i});

    % Position information
    fmrProp.Slice.STCData=tempFmr.Slice.STCData;

    % Save with 'TRF' suffix
    fmrProp.SaveAs([epiNames{i}(1:end-4),'_TRF.fmr']);
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
