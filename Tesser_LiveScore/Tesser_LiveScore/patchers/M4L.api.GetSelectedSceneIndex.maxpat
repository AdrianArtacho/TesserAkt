{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 68.0, 73.0, 637.0, 445.0 ],
		"bglocked" : 0,
		"defrect" : [ 68.0, 73.0, 637.0, 445.0 ],
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
					"maxclass" : "newobj",
					"text" : "route bang <empty>",
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 168.0, 312.0, 106.0, 18.0 ],
					"id" : "obj-27",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 3,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "--->",
					"patching_rect" : [ 128.0, 344.0, 27.0, 18.0 ],
					"id" : "obj-22",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "find the id of the selected scene in the list of scenes and output its position (== its index) in the list ",
					"linecount" : 5,
					"patching_rect" : [ 16.0, 344.0, 122.0, 64.0 ],
					"id" : "obj-21",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "--->",
					"patching_rect" : [ 112.0, 232.0, 27.0, 18.0 ],
					"id" : "obj-25",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "after the live.object points to the current Live Set we ask it for a list of scenes",
					"linecount" : 4,
					"patching_rect" : [ 16.0, 232.0, 108.0, 52.0 ],
					"id" : "obj-24",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "--->",
					"patching_rect" : [ 128.0, 152.0, 27.0, 18.0 ],
					"id" : "obj-23",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "let the live.path point to the current Live Set and feed the live.object below with its ID",
					"linecount" : 4,
					"patching_rect" : [ 16.0, 152.0, 117.0, 52.0 ],
					"id" : "obj-53",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "< first we set the live.path to the main view of the current Live Set and feed the live.object below with its ID",
					"linecount" : 4,
					"patching_rect" : [ 424.0, 152.0, 152.0, 52.0 ],
					"id" : "obj-26",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "< after the live.object points to the current Live Set's main view we ask it for the id of the currently selected scene - we will get something like \"id 1\"",
					"linecount" : 4,
					"patching_rect" : [ 424.0, 264.0, 196.0, 52.0 ],
					"id" : "obj-16",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "help live.object",
					"outlettype" : [ "" ],
					"patching_rect" : [ 424.0, 312.0, 83.0, 16.0 ],
					"id" : "obj-17",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"bgcolor" : [ 0.984314, 0.819608, 0.05098, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"outlettype" : [ "" ],
					"patching_rect" : [ 424.0, 336.0, 50.0, 18.0 ],
					"hidden" : 1,
					"id" : "obj-20",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "help live.path",
					"outlettype" : [ "" ],
					"patching_rect" : [ 424.0, 200.0, 74.0, 16.0 ],
					"id" : "obj-52",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"bgcolor" : [ 0.984314, 0.819608, 0.05098, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"outlettype" : [ "" ],
					"patching_rect" : [ 424.0, 224.0, 50.0, 18.0 ],
					"hidden" : 1,
					"id" : "obj-51",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"prototypename" : "M4L.patching",
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 312.0, 128.0, 18.0, 18.0 ],
					"id" : "obj-15",
					"numinlets" : 1,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"prototypename" : "ML.subpatcher-title",
					"text" : "Get Selected Scene Index",
					"patching_rect" : [ 16.0, 16.0, 311.0, 34.0 ],
					"id" : "obj-48",
					"frgb" : [ 0.3, 0.34, 0.4, 1.0 ],
					"fontname" : "Arial Bold Italic",
					"numinlets" : 1,
					"textcolor" : [ 0.3, 0.34, 0.4, 1.0 ],
					"numoutlets" : 0,
					"fontsize" : 24.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"prototypename" : "ML.patcher-story",
					"text" : "Get the index of the currently selected/highlighted scene.",
					"patching_rect" : [ 16.0, 48.0, 293.0, 19.0 ],
					"id" : "obj-50",
					"frgb" : [ 0.101961, 0.121569, 0.172549, 1.0 ],
					"fontname" : "Arial Italic",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 11.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 312.0, 312.0, 36.0, 18.0 ],
					"id" : "obj-3",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 192.0, 200.0, 37.0, 18.0 ],
					"id" : "obj-19",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 336.0, 200.0, 37.0, 18.0 ],
					"id" : "obj-18",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route selected_scene",
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 312.0, 288.0, 112.0, 18.0 ],
					"id" : "obj-14",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route scenes",
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 168.0, 288.0, 72.0, 18.0 ],
					"id" : "obj-13",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "get selected_scene",
					"outlettype" : [ "" ],
					"patching_rect" : [ 256.0, 232.0, 103.0, 16.0 ],
					"id" : "obj-9",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "path live_set view",
					"outlettype" : [ "" ],
					"patching_rect" : [ 312.0, 152.0, 96.0, 16.0 ],
					"id" : "obj-10",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.object",
					"outlettype" : [ "" ],
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"patching_rect" : [ 312.0, 264.0, 61.0, 18.0 ],
					"id" : "obj-11",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"saved_object_attributes" : 					{
						"_persistence" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.path",
					"outlettype" : [ "", "", "" ],
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"patching_rect" : [ 312.0, 176.0, 66.0, 18.0 ],
					"id" : "obj-12",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 3,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "M4L.api.RemoteMatchIdToIndex",
					"outlettype" : [ "int", "bang" ],
					"color" : [ 0.545098, 0.85098, 0.592157, 1.0 ],
					"patching_rect" : [ 168.0, 344.0, 180.0, 18.0 ],
					"id" : "obj-8",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 2,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "get scenes",
					"outlettype" : [ "" ],
					"patching_rect" : [ 144.0, 232.0, 63.0, 16.0 ],
					"id" : "obj-7",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "path live_set",
					"outlettype" : [ "" ],
					"patching_rect" : [ 168.0, 152.0, 71.0, 16.0 ],
					"id" : "obj-6",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.object",
					"outlettype" : [ "" ],
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"patching_rect" : [ 168.0, 264.0, 61.0, 18.0 ],
					"id" : "obj-5",
					"fontname" : "Arial Bold",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 10.0,
					"saved_object_attributes" : 					{
						"_persistence" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "live.path",
					"outlettype" : [ "", "", "" ],
					"color" : [ 0.984314, 0.819608, 0.05098, 1.0 ],
					"patching_rect" : [ 168.0, 176.0, 66.0, 18.0 ],
					"id" : "obj-4",
					"fontname" : "Arial Bold",
					"numinlets" : 1,
					"numoutlets" : 3,
					"fontsize" : 10.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 168.0, 376.0, 18.0, 18.0 ],
					"id" : "obj-2",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"outlettype" : [ "" ],
					"patching_rect" : [ 312.0, 96.0, 18.0, 18.0 ],
					"id" : "obj-1",
					"numinlets" : 0,
					"numoutlets" : 1,
					"comment" : ""
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-27", 2 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-52", 0 ],
					"destination" : [ "obj-51", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 1 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 1 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-12", 0 ],
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
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [ 321.5, 335.0, 248.0, 335.0, 248.0, 143.0, 177.5, 143.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 1 ],
					"destination" : [ "obj-11", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 1 ],
					"destination" : [ "obj-5", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 1 ],
					"destination" : [ "obj-8", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
