#!/bin/bash
# Indicator of pressing TMUX prefix, copy and insert modes.
declare -A MODE_BG MODE_LABEL
MODE_BG=(
	[P]=blue
	[C]=yellow
	[S]=red
	[T]=cyan
)
MODE_LABEL=(
	[P]=WAIT
	[C]=COPY
	[S]=SYNC
	[T]=TMUX
)

__choose_for_mode() {
	local -n modes=$1
	echo -n "#{?client_prefix,${modes[P]},#{?pane_in_mode,${modes[C]},#{?pane_synchronized,${modes[S]},${modes[T]}}}}"
}

__update_segment_bg() {
	export TMUX_POWERLINE_CUR_SEGMENT_BG="$(tmux display-message -p "$(__choose_for_mode MODE_BG)")"
}
__update_segment_bg

run_segment() {
	echo -n "#[fg=black,bg=$(__choose_for_mode MODE_BG)] $(__choose_for_mode MODE_LABEL)"
	return 0
}
