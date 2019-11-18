@echo off
set CompilerFlags= /FC /nologo /Z7 /LD
set LinkerFlags=/DLL
set bits=x64
set LibraryLocation=..\libs\
set LinkLibraries= obs.lib w32-pthreads.lib avcodec-58.lib avformat-58.lib avutil-56.lib swscale-5.lib swresample-3.lib zlib.lib kernel32.lib user32.lib shell32.lib advapi32.lib winmm.lib psapi.lib
mkdir build > NUL 2> NUL

IF NOT DEFINED vcvars_called (
      pushd %cd%
	  set vcvars_called=1
	  call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" %bits% > NUL 2>NUL 
	  popd )

cd build
cl %CompilerFlags% ..\test.c  /I..\include /link -incremental:no /LIBPATH:%LibraryLocation%  %LinkLibraries% %LinkerFlags% -out:main.dll
cd ..