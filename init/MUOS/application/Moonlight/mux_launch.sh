#!/bin/sh
# HELP: Moonlight
# ICON: moonlight
# GRID: Moonlight

. /opt/muos/script/var/func.sh

echo app >/tmp/act_go

LOVEDIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/application/Moonlight"
MOONDIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/application/Moonlight/moonlight"
GPTOKEYB="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/gptokeyb/gptokeyb2"

SETUP_SDL_ENVIRONMENT

cd "$LOVEDIR" || exit
SET_VAR "system" "foreground_process" "love"
export LD_LIBRARY_PATH="$LOVEDIR/libs:$LD_LIBRARY_PATH"
$GPTOKEYB "love" &
./love gui
kill -9 "$(pidof gptokeyb2)"

cd "$MOONDIR" || exit
COMMAND=$(cat command.txt)
eval "./moonlight $COMMAND"
rm -f "command.txt"
