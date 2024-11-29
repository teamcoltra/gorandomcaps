@ECHO OFF

:: Check if GOPATH is set
IF "%GOPATH%"=="" (
    ECHO GOPATH environment variable is not set.
    GOTO DONE
)

:: Check if 2goarray is installed
IF NOT EXIST "%GOPATH%\bin\2goarray.exe" (
    ECHO Installing 2goarray...
    go install github.com/cratonica/2goarray@latest
    IF ERRORLEVEL 1 (
        ECHO Failed to install 2goarray. Ensure Go is installed and in your PATH.
        GOTO DONE
    )
)

:: Validate input arguments
SET "WINDOWS_ICON=%~1"
SET "DARWIN_ICON=%~2"
SET "LINUX_ICON=%~3"

IF "%WINDOWS_ICON%"=="" (
    ECHO Usage: generate.bat <windows.ico> [darwin.ico] [linux.ico]
    GOTO DONE
)

IF "%DARWIN_ICON%"=="" SET "DARWIN_ICON=%WINDOWS_ICON%"
IF "%LINUX_ICON%"=="" SET "LINUX_ICON=%DARWIN_ICON%"

:: Check if input files exist
FOR %%I IN ("%WINDOWS_ICON%" "%DARWIN_ICON%" "%LINUX_ICON%") DO (
    IF NOT EXIST %%I (
        ECHO Input file %%I does not exist.
        GOTO DONE
    )
)

:: Generate Windows icon file
ECHO Creating iconwin.go
ECHO //+build windows > iconwin.go
ECHO. >> iconwin.go
TYPE "%WINDOWS_ICON%" | "%GOPATH%\bin\2goarray.exe" Data icon >> iconwin.go
IF ERRORLEVEL 1 (
    ECHO Failed to create iconwin.go.
    GOTO DONE
)

:: Generate Darwin icon file
ECHO Creating icondarwin.go
ECHO //+build darwin > icondarwin.go
ECHO. >> icondarwin.go
TYPE "%DARWIN_ICON%" | "%GOPATH%\bin\2goarray.exe" Data icon >> icondarwin.go
IF ERRORLEVEL 1 (
    ECHO Failed to create icondarwin.go.
    GOTO DONE
)

:: Generate Linux icon file
ECHO Creating iconlinux.go
ECHO //+build linux > iconlinux.go
ECHO. >> iconlinux.go
TYPE "%LINUX_ICON%" | "%GOPATH%\bin\2goarray.exe" Data icon >> iconlinux.go
IF ERRORLEVEL 1 (
    ECHO Failed to create iconlinux.go.
    GOTO DONE
)

ECHO Finished creating icons.

:DONE
EXIT /B
