#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
# device_info.txt will be included by default

[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

export PORT_32BIT="Y"
GAMEDIR="/$directory/ports/thewind"

export LD_LIBRARY_PATH="/usr/lib32:$GAMEDIR/libs:$LD_LIBRARY_PATH"
export GMLOADER_DEPTH_DISABLE=1
export GMLOADER_SAVEDIR="$GAMEDIR/gamedata/"
export GMLOADER_PLATFORM="os_linux"

# We log the execution of the script into log.txt
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

cd $GAMEDIR

# Extract and delete unneeded files
if [ -f "./gamedata/THEWIND_v1-0.exe" ]; then
    ./7zzs x "./gamedata/THEWIND_v1-0.exe" -o"./gamedata/" -aos
    mv gamedata/data.win gamedata/game.droid
    rm -f gamedata/*.{dll,ini,exe}
fi
$GPTOKEYB "gmloader" -c ./thewind.gptk &

$ESUDO chmod +x "$GAMEDIR/gmloader"
pm_platform_helper $GAMEDIR/gmloader
./gmloader game.apk

pm_finish
