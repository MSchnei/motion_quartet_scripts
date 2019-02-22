
# specify path to analysis folder
prnt_path="/media/sf_D_DRIVE/Test"

# list all subject names
declare -a subjects=(
				"P1"
				"P3"
				"P7"
				"P8"
				"P9"
        )

# -----------------------------------------------------------------------------

# create Analysis and Tools and Data folder
mkdir -p "${prnt_path}/Analysis"
mkdir -p "${prnt_path}/Tools"
mkdir -p "${prnt_path}/Data"
mkdir -p "${prnt_path}/Tmp"
mkdir -p "${prnt_path}/StimScripts"

# deduce number of subjects
subjLen=${#subjects[@]}

# create directory tree for all subjects
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # create subfolders
  mkdir -p "${prnt_path}/Analysis/${subj}"
	mkdir -p "${prnt_path}/Analysis/${subj}/FNIRT"
  mkdir -p "${prnt_path}/Tools/${subj}"
  mkdir -p "${prnt_path}/Tools/${subj}/Session01"
  mkdir -p "${prnt_path}/Tools/${subj}/Session02"
  mkdir -p "${prnt_path}/Data/${subj}"
  mkdir -p "${prnt_path}/Data/${subj}/Session01"
  mkdir -p "${prnt_path}/Data/${subj}/Session02"
done
