// Batch script for high-pass filtering in BrainVoyagerQX

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path
var InPath = "/media/sf_D_DRIVE/MotionQuartet/Analysis/P1/";

// Set the names that each run/exp should have (stc prefixes)
var InFmrList = [
	"P01_Exp1_Run1/P01_Exp1_Run1_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp1_Run2/P01_Exp1_Run2_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp1_Run3/P01_Exp1_Run3_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp2_Run1/P01_Exp2_Run1_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp2_Run2/P01_Exp2_Run2_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp3_Run1/P01_Exp3_Run1_SCSTBL_MotCorSPM_nrw.fmr",
	"P01_Exp3_Run2/P01_Exp3_Run2_SCSTBL_MotCorSPM_nrw.fmr",
	];

//----------------------------------------------------------------

var NrOfRuns = InFmrList.length;

for(count = 1; count <= NrOfRuns; count++){

    var InFmrPath = InPath + InFmrList[count-1];

    // Open the run
    var docFMR = bvqx.OpenDocument(InFmrPath);

		// High-pass filtering (note: BV first applies linear trend removal [LTR])
    docFMR.TemporalHighPassFilterGLMFourier(5);
    ResultFileName = docFMR.FileNameOfPreprocessdFMR;
    docFMR.Close();
    docFMR = bvqx.OpenDocument(ResultFileName);

    bvqx.PrintToLog(InFmrPath + " finished.");
};

bvqx.PrintToLog("---/All Done---");
