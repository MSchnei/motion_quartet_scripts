// Batch script for creating *.fmr files.

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path
var OutPath = "/media/sf_D_DRIVE/MotionQuartet/Analysis/P9/";

// Set the first dicom file paths per run.
var InDicomList = [
				   "/media/sf_D_DRIVE/MotionQuartet/Data/P09/Session01/sortedDicoms/mbep2d_0p8mm_R3_MB1_HF_para_Series0012/MarSch_20171004 -0012-0001-00001.dcm",
				   "/media/sf_D_DRIVE/MotionQuartet/Data/P09/Session01/sortedDicoms/mbep2d_0p8mm_R3_MB1_HF_anti_Series0013/MarSch_20171004 -0013-0001-00001.dcm",
				   ];

// Set the names that each run/exp should have (stc prefixes)
var RunNameList = [
	"TU/Session01/P09_para",
	"TU/Session01/P09_anti",
	];

// Set number of volumes for every run
var NrVolPerRunList = [5, 5];

//----------------------------------------------------------------

var NrOfRuns = InDicomList.length;

for(count = 1; count <= NrOfRuns; count++){

		// Deduce the input dicom name
    var InDicomPath = InDicomList[count-1];
		// Deduce the name that the new file should have
    var RunName = RunNameList[count-1];


    // Create FMR Project
		var docFMR = bvqx.CreateProjectMosaicFMR("DICOM",
			 																			 InDicomPath,
		                                         NrVolPerRunList[count-1],  //nr of volumes
		                                         0,          //nr of volumes to skip
		                                         false,      //create AMR
		                                         28,         //nr of slices
		                                         RunName,    //STC prefix
		                                         false,      //swap bytes
		                                         1116, 1116,   //dimension of images in volume x, y
		                                         4,          //nr of bytes per pixel, usually 2
		                                         OutPath,    //saving directory
		                                         1,          //number of volumes per file
		                                         186, 186     //dimension of image x, y
		                                         );

    // Give prefixed names
    docFMR.SaveAs(RunName);

    bvqx.PrintToLog(RunName + " finished.");
};

bvqx.PrintToLog("---/All Done---");
