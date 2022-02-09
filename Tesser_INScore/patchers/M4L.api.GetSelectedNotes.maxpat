{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 99.0, 52.0, 718.0, 650.0 ],
		"bglocked" : 0,
		"defrect" : [ 99.0, 52.0, 718.0, 650.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 10.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial Bold",
		"gridonopen" : 0,
		"gridsize" : [ 8.0, 8.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "< after the live.object is set to reference the clip we call the method get_selected_notes to read out the selected MIDI notes",
					"linecount" : 4,
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 352.0, 312.0, 197.0, 52.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-2"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Format of the returned MIDI Notes List:",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 416.0, 376.0, 194.0, 18.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-49"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "notes <count>\nnote <pitch> <starttime> <duration> <velocity> <ismuted>\nnote <pitch> <starttime> <duration> <velocity> <ismuted>\nnote <pitch> <starttime> <duration> <velocity> <ismuted>\nnote <pitch> <starttime> <duration> <velocity> <ismuted>\ndone",
					"linecount" : 6,
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 416.0, 392.0, 276.0, 75.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-48"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 16.0, 432.0, 50.0, 18.0 ],
					"hidden" : 1,
					"id" : "obj-42"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "help live.object",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 16.0, 408.0, 83.0, 16.0 ],
					"bgcolor" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"id" : "obj-43"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 16.0, 304.0, 50.0, 18.0 ],
					"hidden" : 1,
					"id" : "obj-40"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "help live.path",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 16.0, 280.0, 74.0, 16.0 ],
					"bgcolor" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"id" : "obj-39"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "----------->",
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 144.0, 336.0, 54.0, 18.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-36"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "The live.object represents the actual object that has been reached via the live.path - will always stay on that object even if it is moved ",
					"linecount" : 6,
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 16.0, 336.0, 129.0, 75.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-37"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "----------->",
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 144.0, 256.0, 54.0, 18.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-35"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "The live.path object represents a way to get to an object in a Live Set",
					"linecount" : 4,
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 16.0, 232.0, 107.0, 52.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-32"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"prototypename" : "ML.patcher-summary",
					"text" : "Will output the currently selected MIDI notes in a Jitter Matrix",
					"fontname" : "Arial Bold Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 11.0,
					"patching_rect" : [ 240.0, 32.0, 330.0, 19.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-34"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"prototypename" : "ML.subpatcher-title",
					"text" : "GetSelectedNotes",
					"fontname" : "Arial Bold Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 24.0,
					"patching_rect" : [ 16.0, 16.0, 222.0, 34.0 ],
					"textcolor" : [ 0.3, 0.34, 0.4, 1.0 ],
					"frgb" : [ 0.3, 0.34, 0.4, 1.0 ],
					"id" : "obj-33"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"prototypename" : "ML.patcher-story",
					"text" : "Go to the clip that is currently selected in the Clip View, read out all its selected MIDI notes and fill them into a Jitter Matrix.\n\nThe returned JItter Matrix is one-dimensional featuring 5 planes which hold the values: \n\n<pitch> <starttime> <duration> <velocity> <ismuted>",
					"linecount" : 7,
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 11.0,
					"patching_rect" : [ 16.0, 48.0, 328.0, 95.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-31"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Matrix output",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 336.0, 592.0, 74.0, 18.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-30"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "< the live.path outputs the id of the clip and sends it to the live.object",
					"linecount" : 2,
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 376.0, 280.0, 208.0, 29.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-29"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "< Set the path object to the clip currently displayed in the Clip View",
					"linecount" : 3,
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 392.0, 232.0, 132.0, 41.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-28"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Bang triggers the whole process",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0,
					"patching_rect" : [ 264.0, 176.0, 166.0, 18.0 ],
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-27"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 240.0, 208.0, 18.0, 18.0 ],
					"id" : "obj-25"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"prototypename" : "M4L.Arial10",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 312.0, 592.0, 18.0, 18.0 ],
					"id" : "obj-52",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"prototypename" : "M4L.Arial10",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 240.0, 176.0, 18.0, 18.0 ],
					"id" : "obj-51",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t 0 i clear",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 3,
					"fontsize" : 10.0,
					"outlettype" : [ "int", "int", "clear" ],
					"patching_rect" : [ 288.0, 416.0, 67.0, 18.0 ],
					"id" : "obj-14"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 200.0, 535.0, 18.0, 18.0 ],
					"id" : "obj-24"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "setcell $1 val",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 232.0, 488.0, 72.0, 16.0 ],
					"id" : "obj-22"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "zl join",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 2,
					"fontsize" : 10.0,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 232.0, 512.0, 39.0, 18.0 ],
					"id" : "obj-21"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "counter",
					"fontname" : "Arial Bold",
					"numinlets" : 5,
					"numoutlets" : 4,
					"fontsize" : 10.0,
					"outlettype" : [ "int", "", "", "int" ],
					"patching_rect" : [ 232.0, 464.0, 73.0, 18.0 ],
					"id" : "obj-20"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 232.0, 440.0, 38.5, 18.0 ],
					"id" : "obj-19"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend dim",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 312.0, 440.0, 71.0, 18.0 ],
					"id" : "obj-17"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jit.matrix 5 float64 1",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 312.0, 552.0, 104.0, 18.0 ],
					"id" : "obj-15"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route done note notes",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 4,
					"fontsize" : 10.0,
					"outlettype" : [ "", "", "", "" ],
					"patching_rect" : [ 200.0, 384.0, 115.0, 18.0 ],
					"id" : "obj-13"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route get_selected_notes",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 200.0, 360.0, 131.0, 18.0 ],
					"id" : "obj-12"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 240.0, 280.0, 32.5, 18.0 ],
					"id" : "obj-11"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "path live_set view detail_clip",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 240.0, 232.0, 147.0, 16.0 ],
					"id" : "obj-6"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.path",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"numoutlets" : 3,
					"fontsize" : 10.0,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 240.0, 256.0, 51.0, 18.0 ],
					"id" : "obj-4"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "call get_selected_notes",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 200.0, 312.0, 123.0, 16.0 ],
					"id" : "obj-3"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.object",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"outlettype" : [ "" ],
					"patching_rect" : [ 200.0, 336.0, 73.0, 18.0 ],
					"id" : "obj-1"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-43", 0 ],
					"destination" : [ "obj-42", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-51", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-52", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 1 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 2 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 2 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-20", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 1 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 1 ],
					"destination" : [ "obj-21", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 1 ],
					"destination" : [ "obj-1", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
