
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

# download code and data
wget -P ${prnt_path}/Tmp/ "https://zenodo.org/record/1489228/files/motion_quartet_data.zip?download=1"

# unzip the downloaded folders
unzip ${prnt_path}/Tmp/motion_quartet_data.zip -d ${prnt_path}/Tmp/

# remove zipped folders
rm -rf ${prnt_path}/code/motion_quartet_data.zip


# -----------------------------------------------------------------------------


# deduce number of subjects
subjLen=${#subjects[@]}

# create directory tree for all subjects
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # create subfolders
  mkdir -p "${prnt_path}/Analysis/${subj}"
  mkdir -p "${prnt_path}/Tools/${subj}"
  mkdir -p "${prnt_path}/Data/${subj}"
  mkdir -p "${prnt_path}/Data/${subj}/Session01"
  mkdir -p "${prnt_path}/Data/${subj}/Session02"
done
