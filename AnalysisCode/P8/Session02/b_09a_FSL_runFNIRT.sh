subjDir="/media/sf_D_DRIVE/MotionQuartet/Analysis/P8"
refImaFileName="${subjDir}/P08_Exp2_Run1/meanP08_Exp2_Run1_SCSTBL"
inpImaFileName="${subjDir}/P08_Exp2_Run3/meanP08_Exp2_Run3_SCSTBL"

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
cout="${subjDir}/FNIRT/P08_Exp2_Run3_TO_Exp2_Run1_nonlinear_transf"
# output path for transformed image
iout="${subjDir}/FNIRT/P08_Exp2_Run3_TO_Exp2_Run1_nonlinear_imaTest"

# run FNIRT
fnirt --ref=${ref} --in=${in} --refmask=${refmask} --inmask=${inmask} --aff=${aff} --cout=${cout} --iout=${iout} --config=${config}
