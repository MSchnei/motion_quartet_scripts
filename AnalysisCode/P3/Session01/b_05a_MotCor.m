%% Perform motion correction of functional images in  SPM
% This script requires the functions:
% - spm_select_get_nbframes
% - expand_4d_vols
% which need to be added to the SPM12 folder, functions are dfined here:
% https://en.wikibooks.org/wiki/SPM/Working_with_4D_data

clear; clc; close all;

%% settings
% set parent path
pathIN = '/media/sf_D_DRIVE/MotionQuartet/Analysis/P3';

%% get files

% get directories within the folder
dirPaths = cell(8,1);
dirPaths{1,1} = fullfile(pathIN, 'P03_Exp3_Run1');
dirPaths{2,1} = fullfile(pathIN, 'P03_Exp2_Run1');
dirPaths{3,1} = fullfile(pathIN, 'P03_Exp3_Run2');
dirPaths{4,1} = fullfile(pathIN, 'P03_Exp2_Run2');
dirPaths{5,1} = fullfile(pathIN, 'P03_Exp3_Run3');
dirPaths{6,1} = fullfile(pathIN, 'P03_Exp1_Run1');
dirPaths{7,1} = fullfile(pathIN, 'P03_Exp1_Run2');
dirPaths{8,1} = fullfile(pathIN, 'P03_Exp1_Run3');

allfiles = cell(length(dirPaths),1);
for ind1 = 1:length(dirPaths)
    % list all *.nii files
    files = dir(fullfile(dirPaths{ind1},'P*.nii') );
    files = {files.name}';
    for file = files
        niis = spm_select('expand', ...
            fullfile(dirPaths{ind1},file));
        allfiles{ind1} = cellstr(niis);
    end
end


%% create batch

% clear old batches
clear matlabbatch
% define content of the batch
matlabbatch{1}.spm.spatial.realign.estwrite.data = allfiles;
% define estimation options
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 0.8;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 1.6;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 7;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = {'/media/sf_D_DRIVE/MotionQuartet/Analysis/P3/P03_Exp3_Run1/P03_Exp3_Run1_SCSTBL_brain.nii'};
% define reslice options
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 7;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'nrw';

% save SPM batch file:
fileName = [pathIN, '/MotCorNrw.mat'];
save(fileName, 'matlabbatch');
disp(['SPM batch saved as: ', fileName]);

%% run batch

% initialise job configuration
spm_jobman('initcfg')
% run job
spm_jobman('run', matlabbatch);

disp(['Finished running: ', fileName]);
