// Batch script for correcting *.fmr files.

var bvqx = BrainVoyagerQX;
bvqx.PrintToLog("---/Start---");

//----------------------------------------------------------------
// ENTER the following values:

// Set the output path

// Set the names that each run/exp should have (stc prefixes)
var InFmrPath = [
	"/media/sf_D_DRIVE/MotionQuartet/Analysis/P3/TU/Session01/P03_para.fmr",
	"/media/sf_D_DRIVE/MotionQuartet/Analysis/P3/TU/Session01/P03_anti.fmr",
	];

var ListTargetVol = [1, 5];

var NrOfRuns = InFmrPath.length;

for(count = 1; count <= NrOfRuns; count++){

	// Open the run
	var docFMR = bvqx.OpenDocument(InFmrPath[count-1]);

	// Slice scan time correction
	docFMR.CorrectSliceTimingUsingTimeTable(2); // 0: trilinear, 1: cubic spline, 2: windowed sinc
	ResultFileName = docFMR.FileNameOfPreprocessdFMR;
	docFMR.Close();
	docFMR = bvqx.OpenDocument(ResultFileName);

	// Motion Corection
	docFMR.CorrectMotionEx(ListTargetVol[count-1],  // target volume
	                       2, 	// 0 and 1:trilin./trilin., 2:trilin/sinc, 3:sinc/sinc
	                       false, // use full data set(default: false)
	                       100,   // maximum number of iterations(default: 100)
	                       false,  // generate movie
	                       true   // motion estimation parameters in a text file
	                       );

	ResultFileName = docFMR.FileNameOfPreprocessdFMR;
	docFMR.Close();
	docFMR = bvqx.OpenDocument(ResultFileName);

	// High-pass filtering (note: BV first applies linear trend removal [LTR])
	docFMR.TemporalHighPassFilterGLMFourier(2);
	ResultFileName = docFMR.FileNameOfPreprocessdFMR;
	docFMR.Close();
	docFMR = bvqx.OpenDocument(ResultFileName);

	bvqx.PrintToLog(InFmrPath + " finished.");
};

bvqx.PrintToLog("---/All Done---");
