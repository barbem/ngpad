@echo off
rem Compile NGPad.exe en release et copie les DLL necessaires a cote.
rem Usage : build.bat          -> build incremental
rem         build.bat clean    -> supprime obj\ puis rebuild complet
rem La toolchain est attendue dans E:\dev (modifiable via la variable NGPAD_DEV).

setlocal
cd /d "%~dp0"
if "%NGPAD_DEV%"=="" set NGPAD_DEV=E:\dev

if not exist "%NGPAD_DEV%\mingw64\bin\g++.exe" (
  echo Toolchain introuvable dans %NGPAD_DEV%
  exit /b 1
)

set PATH=%NGPAD_DEV%\mingw64\bin;%NGPAD_DEV%\bin;%NGPAD_DEV%\dll64;%PATH%
set CPATH=%NGPAD_DEV%\include
set LIBRARY_PATH=%NGPAD_DEV%\lib

if /i "%~1"=="clean" if exist obj rmdir /s /q obj

rem -j2 : au-dela, la machine manque de memoire.
mingw32-make -j2 mode=release
if errorlevel 1 (
  echo.
  echo *** Echec du build ***
  exit /b 1
)

for %%D in (lua54.dll libtidy.dll libgcc_s_seh-1.dll libstdc++-6.dll libwinpthread-1.dll
            wxbase333u_gcc_mgw.dll wxbase333u_net_gcc_mgw.dll wxbase333u_xml_gcc_mgw.dll
            wxmsw333u_aui_gcc_mgw.dll wxmsw333u_core_gcc_mgw.dll wxmsw333u_stc_gcc_mgw.dll
            wxmsw333u_webview_gcc_mgw.dll) do (
  xcopy /d /y /q "%NGPAD_DEV%\dll64\%%D" . >nul
)

echo.
echo Build OK : %CD%\NGPad.exe
endlocal
