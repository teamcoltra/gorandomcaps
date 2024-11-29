//go:build windows
// +build windows

package main

import (
	"os"
	"syscall"

	"golang.org/x/sys/windows/registry"
)

var (
	user32            = syscall.NewLazyDLL("user32.dll")
	getKeyState       = user32.NewProc("GetKeyState")
	keybdEvent        = user32.NewProc("keybd_event")
	vkCapsLock  uint8 = 0x14 // Virtual Key Code for Caps Lock
)

// ToggleCapsLock toggles the Caps Lock key
func ToggleCapsLock() error {
	ret, _, _ := getKeyState.Call(uintptr(vkCapsLock))
	if ret&0x0001 == 0 {
		// If Caps Lock is off, turn it on
		keybdEvent.Call(uintptr(vkCapsLock), 0, 0, 0)
		keybdEvent.Call(uintptr(vkCapsLock), 0, 0x0002, 0)
	} else {
		// If Caps Lock is on, turn it off
		keybdEvent.Call(uintptr(vkCapsLock), 0, 0, 0)
		keybdEvent.Call(uintptr(vkCapsLock), 0, 0x0002, 0)
	}
	return nil
}

// enableStartup adds the program to Windows startup
func enableStartup() error {
	exePath, err := os.Executable()
	if err != nil {
		return err
	}

	key, _, err := registry.CreateKey(registry.CURRENT_USER, `Software\Microsoft\Windows\CurrentVersion\Run`, registry.SET_VALUE)
	if err != nil {
		return err
	}
	defer key.Close()

	return key.SetStringValue("GoRandomCaps", exePath)
}
