//go:build linux
// +build linux

package main

import (
	"os"
	"os/exec"
	"os/user"
	"path/filepath"
)

// ToggleCapsLock toggles the Caps Lock key on Linux using xdotool
func ToggleCapsLock() error {
	cmd := exec.Command("xdotool", "key", "Caps_Lock")
	err := cmd.Run()
	if err != nil {
		return err
	}
	return nil
}

// enableStartup creates a .desktop file in ~/.config/autostart to enable startup
func enableStartup() error {
	// Get the absolute path of the current executable
	exePath, err := os.Executable()
	if err != nil {
		return err
	}

	// Get the current user's home directory
	usr, err := user.Current()
	if err != nil {
		return err
	}

	// Define the path to the .desktop file
	desktopFilePath := filepath.Join(usr.HomeDir, ".config/autostart/gorandomcaps.desktop")

	// Define the content of the .desktop file
	desktopFileContent := `[Desktop Entry]
Type=Application
Name=GoRandomCaps
Exec=` + exePath + `
X-GNOME-Autostart-enabled=true`

	// Write the .desktop file
	return os.WriteFile(desktopFilePath, []byte(desktopFileContent), 0644)
}
