{
	"name" : "Tesser_LiveScore",
	"version" : 1,
	"creationdate" : 3713457289,
	"modificationdate" : 3713457996,
	"viewrect" : [ 0.0, 103.0, 300.0, 500.0 ],
	"autoorganize" : 1,
	"hideprojectwindow" : 0,
	"showdependencies" : 1,
	"autolocalize" : 0,
	"contents" : 	{
		"patchers" : 		{
			"Tesser_LiveScore.maxpat" : 			{
				"kind" : "patcher",
				"local" : 1,
				"toplevel" : 1
			}
,
			"M4L.api.GetSelectedSceneIndex.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"M4L.api.RemoteMatchIdToIndex.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"M4L.api.GetSelectedTrackIndex.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"M4L.api.GetID.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"packback.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"M4L.api.active.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"my-LtoColl.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"selectInterval.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"maxscore.sax.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"maxscore.bcanvas.maxpat" : 			{
				"kind" : "patcher"
			}
,
			"divmod.maxpat" : 			{
				"kind" : "patcher"
			}

		}
,
		"code" : 		{
			"LiveScore.calculate-bars.js" : 			{
				"kind" : "javascript"
			}
,
			"pane.js" : 			{
				"kind" : "javascript"
			}
,
			"picster-select.js" : 			{
				"kind" : "javascript"
			}
,
			"render2canvas.js" : 			{
				"kind" : "javascript"
			}
,
			"maxscore.proportionalNotation.js" : 			{
				"kind" : "javascript"
			}
,
			"mouseEvents.js" : 			{
				"kind" : "javascript"
			}
,
			"boxSize.js" : 			{
				"kind" : "javascript"
			}
,
			"jit.pane.js" : 			{
				"kind" : "javascript"
			}
,
			"socket.pane.js" : 			{
				"kind" : "javascript"
			}
,
			"n4m.max-fs.js" : 			{
				"kind" : "javascript"
			}
,
			"swissarmyknife.js" : 			{
				"kind" : "javascript"
			}
,
			"scrollbar.js" : 			{
				"kind" : "javascript"
			}
,
			"somecode.js" : 			{
				"kind" : "javascript"
			}

		}
,
		"data" : 		{
			"percussionMap.txt" : 			{
				"kind" : "textfile"
			}
,
			"MaxScoreKeyMap.txt" : 			{
				"kind" : "textfile"
			}
,
			"IPaddresses.txt" : 			{
				"kind" : "textfile",
				"local" : 1
			}

		}
,
		"externals" : 		{
			"sadam.rapidXML.mxo" : 			{
				"kind" : "object"
			}
,
			"sadam.split.mxo" : 			{
				"kind" : "object"
			}

		}

	}
,
	"layout" : 	{

	}
,
	"searchpath" : 	{

	}
,
	"detailsvisible" : 0,
	"amxdtype" : 1835887981,
	"readonly" : 0,
	"devpathtype" : 0,
	"devpath" : ".",
	"sortmode" : 0,
	"viewmode" : 0
}
