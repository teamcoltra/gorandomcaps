@ECHO OFF
SET GO111MODULE=on

REM Set output directory
SET OUTPUT_DIR=build
IF NOT EXIST "%OUTPUT_DIR%" (
    MKDIR "%OUTPUT_DIR%"
)

REM Build for Windows
ECHO Building for Windows...
SET GOOS=windows
SET GOARCH=amd64
go build -ldflags "-H=windowsgui" -o "%OUTPUT_DIR%\gorandomcaps.exe"
IF %ERRORLEVEL% NEQ 0 (
    ECHO Failed to build Windows executable.
    EXIT /B 1
)
ECHO Successfully built Windows executable: %OUTPUT_DIR%\gorandomcaps.exe

@REM REM Build for macOS
@REM ECHO Building for macOS...
@REM SET GOOS=darwin
@REM SET GOARCH=amd64
@REM go build -o "%OUTPUT_DIR%\gorandomcaps-mac"
@REM IF %ERRORLEVEL% NEQ 0 (
@REM     ECHO Failed to build macOS executable.
@REM     EXIT /B 1
@REM )
@REM ECHO Successfully built macOS executable: %OUTPUT_DIR%\gorandomcaps-mac

@REM REM Build for Linux
@REM ECHO Building for Linux...
@REM SET GOOS=linux
@REM SET GOARCH=amd64
@REM go build -o "%OUTPUT_DIR%\gorandomcaps-linux"
@REM IF %ERRORLEVEL% NEQ 0 (
@REM     ECHO Failed to build Linux executable.
@REM     EXIT /B 1
@REM )
@REM ECHO Successfully built Linux executable: %OUTPUT_DIR%\gorandomcaps-linux

@REM ECHO All builds completed. Check the %OUTPUT_DIR% directory for output files.
