// Batch script for creating *.fmr files.

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path
var OutPath = "/media/sf_D_DRIVE/MotionQuartet/Analysis/P1/";

// Set the first dicom file paths per run.
var InDicomList = [
				   "/media/sf_D_DRIVE/MotionQuartet/Data/P01/Session01/vkem_150803_MQ_S01/20150803_142253.890000/13_mbep2d_0p8mm_R3_MB1_exp2_run1/vkem_150803_MQ_S01-0013-0001-00001.dcm",
				   "/media/sf_D_DRIVE/MotionQuartet/Data/P01/Session01/vkem_150803_MQ_S01/20150803_142253.890000/11_mbep2d_0p8mm_R3_MB1_topup/vkem_150803_MQ_S01-0011-0001-00001.dcm",
				   ];

// Set the names that each run/exp should have (stc prefixes)
var RunNameList = [
	"TU/Session01/P01_para",
	"TU/Session01/P01_anti",
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
