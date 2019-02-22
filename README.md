# motion_quartet_scripts
Stimulus and analysis scripts accompanying the manuscript "Columnar clusters in the human motion complex reflect consciously perceived motion axis"

# motion_quartet_scripts

This repository hosts code for the analysis of the following paper:

[Columnar clusters in the human motion complex reflect consciously perceived motion axis](https://www.biorxiv.org/)

## Notes
More details on data and preprocessing can be found in the Supplementary Materials accompanying the manuscript.

## Download code and data
The data is provided in BIDS format. Code and data can be downloaded by running:

**download code and data**
```
# specify path to parent folder
prnt_path="/path/to/Downloads/"

# create folders for data and code
mkdir -p "${prnt_path}/Tools"
mkdir -p "${prnt_path}/Data"

# download
wget -P ${prnt_path}/Tools/ "https://zenodo.org/record/1489246/motion_quartet_scripts-1.0.0.zip"
wget -P ${prnt_path}/Data/ "https://zenodo.org/record/1489227/motion_quartet_data.zip"
```
