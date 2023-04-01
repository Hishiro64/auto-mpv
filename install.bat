@echo off

cd mpv
wget https://www.7-zip.org/a/7zr.exe

wget https://github.com/shinchiro/mpv-winbuild-cmake/releases/download/20230401/mpv-x86_64-v3-20230401-git-0f13c38.7z
.\7zr.exe x .\mpv-x86_64-v3-20230401-git-0f13c38.7z
del .\mpv-x86_64-v3-20230401-git-0f13c38.7z

wget https://www.python.org/ftp/python/3.10.10/python-3.10.10-embed-amd64.zip
tar -xf .\python-3.10.10-embed-amd64.zip
del .\python-3.10.10-embed-amd64.zip

wget https://github.com/vapoursynth/vapoursynth/releases/download/R61/VapourSynth64-Portable-R61.7z
.\7zr.exe x .\VapourSynth64-Portable-R61.7z -y
del .\VapourSynth64-Portable-R61.7z

wget https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
tar -xf .\uosc.zip -C ./portable_config
del .\uosc.zip

cd .\portable_config\scripts
wget https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua

wget https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SmartCopyPaste.lua

cd ..\
cd vs

wget https://raw.githubusercontent.com/hooke007/MPV_lazy/main/portable_config/vs/rife_2x.vpy

cd ..\
cd shaders

wget https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/7c151e0af2281ae6657809be1f3c5efe0e325c38/KrigBilateral.glsl

cd ..\..
cd vapoursynth64\plugins

wget https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/releases/latest/download/RIFE-r9-win64.7z
..\..\7zr.exe x .\RIFE-r9-win64.7z
del RIFE-r9-win64.7z

wget https://github.com/vapoursynth/vs-miscfilters-obsolete/releases/latest/download/miscfilters-r2.7z
..\..\7zr.exe x .\miscfilters-r2.7z
move .\win64\MiscFilters.dll .\
rmdir /Q/S .\docs
rmdir /Q/S .\win32
rmdir /Q/S .\win64
del miscfilters-r2.7z

wget https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF/releases/latest/download/VMAF-r10-win64.7z
..\..\7zr.exe x .\VMAF-r10-win64.7z
del VMAF-r10-win64.7z

md models\rife-v4
cd models\rife-v4
wget https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.bin
wget https://raw.githubusercontent.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/master/models/rife-v4/flownet.param

cd ..\..\..\..\

wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe

del 7zr.exe

.\mpv.exe

