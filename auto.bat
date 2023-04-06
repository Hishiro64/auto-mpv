@echo off
TITLE Auto MPV

cls

echo:
echo   Installing  MPV
echo ```````````````````

:: End all instances of MPV
TASKKILL /IM mpv.exe /F > nul 2>&1

:: Set path 
set "MPV=%~dp0mpv"

:: Correct Path
cd %MPV%

:: Download portable wget
curl -O -C - --progress-bar https://eternallybored.org/misc/wget/1.21.3/64/wget.exe 

:: Download latest prebuild MPV build for windows
setlocal EnableDelayedExpansion
set "count=0"

for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/shinchiro/mpv-winbuild-cmake/releases/latest ^| find "mpv-x86_64-v3"') do (
    set /a count+=1
    if !count! == 2 (
        "%MPV%\wget.exe" -q -N --show-progress -O mpv-x86_64-v3.7z %%B
        goto :leave
    )
)
:leave

:: Download portable 7zip
"%MPV%\wget.exe" -q -N --show-progress https://www.7-zip.org/a/7zr.exe

:: Extract MPV
"%MPV%\7zr.exe" x .\mpv-x86_64-v3.7z -y > nul
del .\mpv-x86_64-v3.7z

:: Download embeded Python ~3.11.2
"%MPV%\wget.exe" -q -N --show-progress https://www.python.org/ftp/python/3.11.2/python-3.11.2-embed-amd64.zip
tar -xf .\python-3.11.2-embed-amd64.zip
del .\python-3.11.2-embed-amd64.zip

:: Download VapourSynth64 Portable ~R62
"%MPV%\wget.exe" -q -N --show-progress https://github.com/vapoursynth/vapoursynth/releases/download/R62/VapourSynth64-Portable-R62.7z
"%MPV%\7zr.exe" x .\VapourSynth64-Portable-R62.7z -y > nul
del .\VapourSynth64-Portable-R62.7z

:: Download latest version of yt-dlp
"%MPV%\wget.exe" -q -N --show-progress https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe

:: Download latest version of uosc
"%MPV%\wget.exe" -q -N --show-progress https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
tar -xf .\uosc.zip -C ./portable_config

pushd .\portable_config\script-opts

:: Download latest version of script-opts
"%MPV%\wget.exe" -q -N --show-progress http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/mpv/portable_config/script-opts/SmartCopyPaste.conf
"%MPV%\wget.exe" -q -N --show-progress http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/mpv/portable_config/script-opts/thumbfast.conf
"%MPV%\wget.exe" -q -N --show-progress http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/mpv/portable_config/script-opts/uosc.conf

cd ..\

:: Download latest version of input.conf and mpv.conf
"%MPV%\wget.exe" -q -N --show-progress http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/mpv/portable_config/mpv.conf
"%MPV%\wget.exe" -q -N --show-progress http://192.168.1.100:9006/test111/mpv-config/raw/branch/main/mpv/portable_config/input.conf

cd scripts

:: Download latest version of scripts
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SmartCopyPaste.lua

cd ..\
cd vs

:: Download latest version of VapourSynth scripts
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/hooke007/MPV_lazy/main/portable_config/vs/rife_2x.vpy

cd ..\
cd shaders

:: Download latest version of shaders
"%MPV%\wget.exe" -q -N --show-progress https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/7c151e0af2281ae6657809be1f3c5efe0e325c38/KrigBilateral.glsl
"%MPV%\wget.exe" -q -N --show-progress https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_16-0-4-1.glsl
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/bloc97/Anime4K/master/glsl/Restore/Anime4K_Restore_CNN_L.glsl

popd
pushd vapoursynth64\plugins

:: Download latest version of RIFE
"%MPV%\wget.exe" -q -N --show-progress https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/releases/download/r9/RIFE-r9-win64.7z
"%MPV%\7zr.exe" x .\RIFE-r9-win64.7z -y > nul
del RIFE-r9-win64.7z

:: Download latest version of miscfilters
"%MPV%\wget.exe" -q -N --show-progress https://github.com/vapoursynth/vs-miscfilters-obsolete/releases/download/R2/miscfilters-r2.7z
"%MPV%\7zr.exe" x .\miscfilters-r2.7z -y > nul
move .\win64\MiscFilters.dll .\ > nul
rmdir /Q/S .\docs
rmdir /Q/S .\win32
rmdir /Q/S .\win64
del miscfilters-r2.7z

:: Download latest version of VMAF
"%MPV%\wget.exe" -q -N --show-progress https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF/releases/download/r10/VMAF-r10-win64.7z
"%MPV%\7zr.exe" x .\VMAF-r10-win64.7z -y > nul
del VMAF-r10-win64.7z

if not exist "models\rife-v4" mkdir models\rife-v4
cd models\rife-v4

:: Download latest version of RIFE-v4 model
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.bin
"%MPV%\wget.exe" -q -N --show-progress https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.param

popd

start .\mpv.exe

echo:
echo Installation Finished
echo:   exiting...
echo:

exit

