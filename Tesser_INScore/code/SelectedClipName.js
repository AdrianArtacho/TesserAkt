var currentClip = null;

// Get Clip Name
function getClipName (currentClip) {
	var liveSet = new LiveAPI (dummyCallback, 'live_set view selected_track clip_slots ' + currentClip + ' clip')
	var clipName = liveSet.get('name');
	outlet(1, clipName);
}

function dummyCallback (){}