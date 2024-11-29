//go:build darwin
// +build darwin

package main

import (
	"os"
	"os/exec"
	"os/user"
	"path/filepath"
)

// ToggleCapsLock toggles the Caps Lock key on macOS using AppleScript
func ToggleCapsLock() error {
	cmd := exec.Command("osascript", "-e", `tell application "System Events" to key code 57`)
	err := cmd.Run()
	if err != nil {
		return err
	}
	return nil
}

// enableStartup creates a Launch Agent plist file to enable startup
func enableStartup() error {
	// Get the absolute path of the current executable
	exePath, err := os.Executable()
	if err != nil {
		return err
	}

	// Get the user's home directory
	usr, err := user.Current()
	if err != nil {
		return err
	}

	// Define the path to the Launch Agent plist file
	plistPath := filepath.Join(usr.HomeDir, "Library/LaunchAgents/com.gorandomcaps.plist")

	// Define the content of the plist file
	plistContent := `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.gorandomcaps</string>
    <key>ProgramArguments</key>
    <array>
        <string>` + exePath + `</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>`

	// Write the plist file with the desired content
	return os.WriteFile(plistPath, []byte(plistContent), 0644)
}
