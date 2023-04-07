@echo off
TITLE Auto MPV ⚙

:: End all instances of MPV
TASKKILL /IM mpv.exe /F > nul 2>&1

cls

:: Set path 
set "MPV=%~dp0"

:: Set Wget command
set "Download-->=%MPV%\wget.exe -q -N --show-progress"

:: Set 7zr command
set "Extract-->=%MPV%\7zr.exe -y x" 

:: Correct path
cd %MPV%

:: Change header based on install status 
echo:
if exist ".auto-is-installed" (
    echo   Updating  MPV
    echo `````````````````
) else (
    echo   Installing  MPV
    echo ```````````````````

    :: Create directories if it doesn't exist
    if not exist ".\portable_config" mkdir .\portable_config
    if not exist ".\portable_config\script-opts" mkdir .\portable_config\script-opts
    if not exist ".\portable_config\vs" mkdir .\portable_config\vs
    if not exist ".\portable_config\shaders" mkdir .\portable_config\shaders
    if not exist ".\vapoursynth64\plugins\models\rife-v4" mkdir .\vapoursynth64\plugins\models\rife-v4
)

:: Download portable Wget
curl -O -C - --progress-bar https://eternallybored.org/misc/wget/1.21.3/64/wget.exe 

:: Download latest pre-build MPV build for Windows
setlocal EnableDelayedExpansion
set "instance=0"

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/shinchiro/mpv-winbuild-cmake/releases/latest ^| find "mpv-x86_64-v3"') do (
    set /a instance+=1
    if !instance! == 2 (
        %Download-->% -O mpv-x86_64-v3.7z %%B
        goto :leave
    )
)
:leave

:: Download portable 7zip
%Download-->% https://www.7-zip.org/a/7zr.exe

:: Extract MPV
%Extract-->% .\mpv-x86_64-v3.7z > nul
del .\mpv-x86_64-v3.7z

:: Download embedded Python ~3.11.2
%Download-->% https://www.python.org/ftp/python/3.11.2/python-3.11.2-embed-amd64.zip
tar -xf .\python-3.11.2-embed-amd64.zip
del .\python-3.11.2-embed-amd64.zip

:: Download VapourSynth64 Portable ~R62
%Download-->% https://github.com/vapoursynth/vapoursynth/releases/download/R62/VapourSynth64-Portable-R62.7z
%Extract-->% .\VapourSynth64-Portable-R62.7z > nul
del .\VapourSynth64-Portable-R62.7z

:: Download latest version of yt-dlp
%Download-->% https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe

:: Download latest version of uosc
%Download-->% https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
tar -xf .\uosc.zip -C .\portable_config

pushd .\portable_config\script-opts

:::::::::::::::::::
::  script-opts  ::
::::::::::::::::::: 

:: Download latest version of script-opts
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/script-opts/SmartCopyPaste.conf
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/script-opts/thumbfast.conf
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/script-opts/uosc.conf

cd ..\

:::::::::::::::::::::::
::  portable_config  ::
::::::::::::::::::::::: 

:: Download latest version of input.conf and mpv.conf
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/mpv.conf
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/input.conf

cd scripts

:::::::::::::::
::  scripts  ::
::::::::::::::: 

:: Download latest version of scripts
%Download-->% https://raw.githubusercontent.com/Hishiro64/auto-mpv/main/mpv/portable_config/scripts/Auto-Mpv.lua
%Download-->% https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua
%Download-->% https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SmartCopyPaste.lua

cd ..\
cd vs

::::::::::
::  vs  ::
::::::::::

:: Download latest version of VapourSynth scripts
%Download-->% https://raw.githubusercontent.com/hooke007/MPV_lazy/main/portable_config/vs/rife_2x.vpy

cd ..\
cd shaders

:::::::::::::::
::  shaders  ::
:::::::::::::::

:: Download latest version of shaders
%Download-->% https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/7c151e0af2281ae6657809be1f3c5efe0e325c38/KrigBilateral.glsl
%Download-->% https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_16-0-4-1.glsl
%Download-->% https://raw.githubusercontent.com/bloc97/Anime4K/master/glsl/Restore/Anime4K_Restore_CNN_L.glsl

popd
pushd vapoursynth64\plugins

:: Download latest version of RIFE
%Download-->% https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/releases/download/r9/RIFE-r9-win64.7z
%Extract-->% .\RIFE-r9-win64.7z > nul
del RIFE-r9-win64.7z

:: Download latest version of miscfilters and extract only 64bit MiscFilters.dll
%Download-->% https://github.com/vapoursynth/vs-miscfilters-obsolete/releases/download/R2/miscfilters-r2.7z
%Extract-->% .\miscfilters-r2.7z win64\MiscFilters.dll > nul
move .\win64\MiscFilters.dll .\ > nul
rmdir /Q/S .\win64
del miscfilters-r2.7z

:: Download latest version of VMAF
%Download-->% https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF/releases/download/r10/VMAF-r10-win64.7z
%Extract-->% .\VMAF-r10-win64.7z > nul
del VMAF-r10-win64.7z

cd models\rife-v4

:: Download latest version of RIFE-v4 model
%Download-->% https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.bin
%Download-->% https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.param

popd

start .\mpv.exe

:: Change install status
echo "1">.\.auto-is-installed

echo:
echo Installation Finished
echo:   Exiting...
echo:

exit