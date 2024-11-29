# GoRandomCaps

GoRandomCaps is a fun and harmless prank application written in Go. It toggles the Caps Lock key randomly at intervals, and provides a system tray interface with additional features like enabling startup on boot and rebooting the application.

> **Disclaimer:** This project was built and tested on Windows. While compatibility with Linux and macOS is intended, these platforms are currently untested. Use at your own discretion.

---

## Features

- Randomly toggles Caps Lock at intervals.
- Runs as a system tray application.
- Options to enable the application to start on boot.
- Cross-platform support for Windows, Linux, and macOS (Windows tested, others untested).

---

## Installation

### Windows
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/gorandomcaps.git
   cd gorandomcaps
   ```

2. Build the project:
   ```bash
   build.bat
   ```
   The executable will be created in the `build/` directory.

3. Run the application:
   ```bash
   ./build/gorandomcaps.exe
   ```

### Linux and macOS
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/gorandomcaps.git
   cd gorandomcaps
   ```

2. Make the build script executable:
   ```bash
   chmod +x build.sh
   ```

3. Build the project:
   ```bash
   ./build.sh
   ```
   The executables for Linux and macOS will be created in the `build/` directory.

4. Run the application:
   ```bash
   ./build/gorandomcaps-linux   # For Linux
   ./build/gorandomcaps         # For macOS
   ```

---

## Usage

1. When the application is started, it will appear in the system tray.
2. Options in the system tray menu:
   - **Reboot:** Restarts the application.
   - **Start on Boot:** Adds the application to startup on your system.

---

## How It Works

The main functionality toggles the Caps Lock key at random intervals (between 0 and 10 minutes) in the background. Platform-specific implementations handle the Caps Lock toggle and startup options:
- **Windows:** Uses `keybd_event` from the Windows API.
- **Linux:** Utilizes `xdotool` for key simulation.
- **macOS:** Leverages AppleScript for key toggling.

---

## Icons

The project uses custom icons for the system tray. Icons are converted into Go arrays using the `2goarray` tool. Scripts (`generate.bat` and `generate.sh`) handle the conversion.

To generate icons:
1. Place your `.ico` files in the `icon/` directory.
2. Run the appropriate script:
   - Windows: `generate.bat`
   - Linux/macOS: `generate.sh`

---

## Contributing

Feel free to contribute to this project! Report issues, suggest features, or submit pull requests.

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Description of changes"
   ```
4. Push to your fork and open a pull request.

---

## Disclaimer

This project is intended for entertainment purposes only. The developer is not responsible for any unintended consequences arising from the use of this application.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
