subjDir="/media/sf_D_DRIVE/MotionQuartet/Analysis/P1"
refImaFileName="${subjDir}/P01_Exp2_Run1/meanP01_Exp2_Run1_SCSTBL"
inpImaFileName="${subjDir}/P01_Exp2_Run3/meanP01_Exp2_Run3_SCSTBL"

# path to reference
ref="${refImaFileName}"
# path to reference file brain mask
refmask="${refImaFileName}_msk"
# path to input file
in="${inpImaFileName}"
# path to input file brain mask
inmask="${inpImaFileName}_msk"
# path to affine matrix (from FLIRT, FNIRT will use this as a starting point)
aff="${subjDir}/FNIRT/FLIRT.mat"
# path to config file
config="${subjDir}/FNIRT/EPI_2_EPIextra.cnf"
# output path for coefficients
cout="${subjDir}/FNIRT/P01_Exp2_Run3_TO_Exp2_Run1_nonlinear_transf"
# output path for transformed image
iout="${subjDir}/FNIRT/P01_Exp2_Run3_TO_Exp2_Run1_nonlinear_imaTest"

# run FNIRT
fnirt --ref=${ref} --in=${in} --refmask=${refmask} --inmask=${inmask} --aff=${aff} --cout=${cout} --iout=${iout} --config=${config}
