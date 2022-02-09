// Get Playing Clip
function getPlayingClip() {
// function bang() {
	var selectedTrack = new LiveAPI("live_set view selected_track");
	var playingClipIndex = selectedTrack.get("playing_slot_index");
	outlet(0, playingClipIndex);
}