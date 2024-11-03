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
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

# Variables
GAMEDIR="/$directory/ports/ungratefulbirdsngd"

# CD and set permissions
cd $GAMEDIR
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1
$ESUDO chmod +x -R $GAMEDIR/*

# Exports
export LD_LIBRARY_PATH="/usr/lib:$GAMEDIR/lib:$LD_LIBRARY_PATH"

# Delete unneeded files
if [ -f "./gamedata/UNGRATEFUL BIRDS No Good Deed.exe" ]; then
    rm -f gamedata/*.{exe,ini}
fi

# Display loading splash
if [ -f "$GAMEDIR/gamedata/game.droid" ]; then
[ "$CFW_NAME" == "muOS" ] && $ESUDO ./tools/splash "splash.png" 1 # muOS only workaround
    $ESUDO ./tools/splash "splash.png" 2000
fi

# Run the game
$GPTOKEYB "gmloadernext" -c "./ungratefulbirdsngd.gptk" &
pm_platform_helper "$GAMEDIR/gmloadernext"
./gmloadernext

# Kill processes
pm_finish
