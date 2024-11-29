package main

import (
	"math/rand"
	"time"

	"gorandomcaps/icon" // Import the icon package

	"github.com/getlantern/systray"
)

func main() {
	// Start the Caps Lock toggler in a separate goroutine
	go runCapsLockToggler()

	// Run the systray UI
	systray.Run(onReady, nil) // No cleanup needed
}

func onReady() {
	// Set the icon and tooltip
	systray.SetIcon(icon.Data) // Use the embedded icon data
	systray.SetTitle("Alarms")
	systray.SetTooltip("Manages notification alarms")

	// Add menu options
	rebootItem := systray.AddMenuItem("Reboot", "Reboot System")
	startOnBootItem := systray.AddMenuItem("Start on Boot", "Enable program to run on startup")

	// Handle menu item clicks
	go func() {
		for {
			select {
			case <-rebootItem.ClickedCh:
				systray.Quit()
			case <-startOnBootItem.ClickedCh:
				err := enableStartup()
				if err != nil {
					println("Failed to enable startup:", err)
				} else {
					println("Program successfully added to startup!")
				}
			}
		}
	}()
}

func runCapsLockToggler() {
	for range time.Tick(time.Duration(rand.Intn(10)) * time.Minute) {
		// Toggle Caps Lock
		ToggleCapsLock()
	}
}
