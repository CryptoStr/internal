#!/bin/bash
# HELP: RGB Controller
# ICON: rgbcontroller
# GRID: RGB

. /opt/muos/script/var/func.sh

echo app >/tmp/act_go

# Define paths and commands
LOVEDIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/application/RGB Controller"
GPTOKEYB="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/gptokeyb/gptokeyb2.armhf"
CONFDIR="$LOVEDIR/conf/"

SETUP_SDL_ENVIRONMENT

# Export environment variables
export XDG_DATA_HOME="$CONFDIR"

# Launcher
cd "$LOVEDIR" || exit
SET_VAR "system" "foreground_process" "love"
export LD_LIBRARY_PATH="$LOVEDIR/libs:$LD_LIBRARY_PATH"
$GPTOKEYB "love" &
./love rgbcontroller
kill -9 "$(pidof gptokeyb2.armhf)"
