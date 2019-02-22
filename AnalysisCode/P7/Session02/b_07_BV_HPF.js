// Batch script for high-pass filtering in BrainVoyagerQX

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path
var InPath = "/media/sf_D_DRIVE/MotionQuartet/Analysis/P7/";

// Set the names that each run/exp should have (stc prefixes)
var InFmrList = [
	"P07_Exp2_Run3/P07_Exp2_Run3_SCSTBL_MotCorSPM_nrw.fmr",
	"P07_Exp3_Run4/P07_Exp3_Run4_SCSTBL_MotCorSPM_nrw.fmr",
	"P07_Exp2_Run4/P07_Exp2_Run4_SCSTBL_MotCorSPM_nrw.fmr",
	"P07_Exp3_Run5/P07_Exp3_Run5_SCSTBL_MotCorSPM_nrw.fmr",
	"P07_Exp2_Run5/P07_Exp2_Run5_SCSTBL_MotCorSPM_nrw.fmr",
	"P07_Exp3_Run6/P07_Exp3_Run6_SCSTBL_MotCorSPM_nrw.fmr",
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
