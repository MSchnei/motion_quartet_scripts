// Batch script for running slice time correction.

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path
var InPath = "/media/sf_D_DRIVE/MotionQuartet/Analysis/P9/";

// Set the names that each run/exp should have (stc prefixes)
var InFmrList = [
	"P09_Exp2_Run4/P09_Exp2_Run4.fmr",
	"P09_Exp3_Run4/P09_Exp3_Run4.fmr",
	"P09_Exp2_Run5/P09_Exp2_Run5.fmr",
	"P09_Exp3_Run5/P09_Exp3_Run5.fmr",
	"P09_Exp2_Run6/P09_Exp2_Run6.fmr",
	"P09_Exp3_Run6/P09_Exp3_Run6.fmr",
	];

//----------------------------------------------------------------

var NrOfRuns = InFmrList.length;

for(count = 1; count <= NrOfRuns; count++){

    var InFmrPath = InPath + InFmrList[count-1];

    // Open the run
    var docFMR = bvqx.OpenDocument(InFmrPath);

		// Slice scan time correction
    docFMR.CorrectSliceTimingUsingTimeTable(2); // 0: trilinear, 1: cubic spline, 2: windowed sinc
    ResultFileName = docFMR.FileNameOfPreprocessdFMR;
    docFMR.Close();
    docFMR = bvqx.OpenDocument(ResultFileName);

    bvqx.PrintToLog(InFmrPath + " finished.");
};

bvqx.PrintToLog("---/All Done---");
