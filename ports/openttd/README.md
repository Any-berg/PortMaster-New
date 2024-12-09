## Notes

Everything is included and ready to run.

If the mouse speed needs adjusting, edit OpenTTD.sh and adjust it in the "# Set mouse speed based on screen resolution" section.

Thanks to [OpenTTD](https://github.com/OpenTTD/OpenTTD) for this open source version that decently mimics Transport Tycoon Deluxe!

</br>

## Controls

| Button | Action |
|--|--| 
|D-Pad|Move screen|
|L-stick/R-stick|Move mouse|
|B|Slow mouse down|
|A/L1/R1/L2/R2|Mouse click|

</br>

## Stickless devices

| Button | Action |
|--|--| 
|D-Pad|Move mouse|
|B|Slow mouse down|
|A/L1/R1/L2/R2|Mouse click|

</br>

## Compile

Extract the contents of OpenTTD-13.4-src.7z to openttd-13.4/
Edit openttd-13.4/src/video/sdl2_v.cpp
Find the line SDL_SetHint(SDL_HINT_FRAMEBUFFER_ACCELERATION, "0"); and comment it out with // if it isn't already.
Save changes.

```shell
cd openttd-13.4
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j4
```