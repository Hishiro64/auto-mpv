@echo off

set "MPV=%~dp0mpv"

cd %MPV%

curl -O --progress-bar https://eternallybored.org/misc/wget/1.21.3/64/wget.exe

"%MPV%\wget.exe" -q --show-progress https://www.7-zip.org/a/7zr.exe

"%MPV%\wget.exe" -q --show-progress https://github.com/shinchiro/mpv-winbuild-cmake/releases/download/20230401/mpv-x86_64-v3-20230401-git-0f13c38.7z
.\7zr.exe x .\mpv-x86_64-v3-20230401-git-0f13c38.7z -y > nul
del .\mpv-x86_64-v3-20230401-git-0f13c38.7z

"%MPV%\wget.exe" -q --show-progress https://www.python.org/ftp/python/3.11.2/python-3.11.2-embed-amd64.zip
tar -xf .\python-3.11.2-embed-amd64.zip
del .\python-3.11.2-embed-amd64.zip

"%MPV%\wget.exe" -q --show-progress https://github.com/vapoursynth/vapoursynth/releases/download/R62/VapourSynth64-Portable-R62.7z
.\7zr.exe x .\VapourSynth64-Portable-R62.7z -y > nul
del .\VapourSynth64-Portable-R62.7z

"%MPV%\wget.exe" -q --show-progress https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
tar -xf .\uosc.zip -C ./portable_config
del .\uosc.zip

cd .\portable_config\scripts
"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua

"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SmartCopyPaste.lua

cd ..\
cd vs

"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/hooke007/MPV_lazy/main/portable_config/vs/rife_2x.vpy

cd ..\
cd shaders

"%MPV%\wget.exe" -q --show-progress https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/7c151e0af2281ae6657809be1f3c5efe0e325c38/KrigBilateral.glsl
"%MPV%\wget.exe" -q --show-progress https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_16-0-4-1.glsl
"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/bloc97/Anime4K/master/glsl/Restore/Anime4K_Restore_CNN_L.glsl

cd ..\..
cd vapoursynth64\plugins

"%MPV%\wget.exe" -q --show-progress https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/releases/download/r9/RIFE-r9-win64.7z
..\..\7zr.exe x .\RIFE-r9-win64.7z -y > nul
del RIFE-r9-win64.7z

"%MPV%\wget.exe" -q --show-progress https://github.com/vapoursynth/vs-miscfilters-obsolete/releases/download/R2/miscfilters-r2.7z
..\..\7zr.exe x .\miscfilters-r2.7z -y > nul
move .\win64\MiscFilters.dll .\ > nul
rmdir /Q/S .\docs
rmdir /Q/S .\win32
rmdir /Q/S .\win64
del miscfilters-r2.7z

"%MPV%\wget.exe" -q --show-progress https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF/releases/download/r10/VMAF-r10-win64.7z
..\..\7zr.exe x .\VMAF-r10-win64.7z -y > nul
del VMAF-r10-win64.7z

md models\rife-v4
cd models\rife-v4
"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.bin
"%MPV%\wget.exe" -q --show-progress https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.param

cd ..\..\..\..\

"%MPV%\wget.exe" -q --show-progress https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe

del 7zr.exe
del wget.exe

start .\mpv.exe

echo:
echo Installation Finished 

exit

