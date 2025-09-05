# NVIDIA Instant Replay AutoStart

This PowerShell script ensures that **NVIDIA Instant Replay (ShadowPlay)** is always active when Windows starts. It automatically sends the configured hotkey to start Instant Replay if it is disabled.

---

## Requirements

* Windows OS
* NVIDIA Overlay/GeForce Experience installed
* Hotkey configured as **SHIFT + ALT + F10** to start Instant Replay

---

## Setting Up the Scheduled Task

1. Open **Task Scheduler** on Windows.
2. Create a new task with the following settings:

### General

* **Run only when the user is logged on**
* **Run with highest privileges**

### Triggers

* **At log on**

### Actions

* **Start a program**

  * Program/script: `powershell.exe`
  * Add arguments (optional):

    ```text
    -WindowStyle Hidden -ExecutionPolicy Bypass -File "nvidia.ps1"
    ```
  * Start in (optional): Folder where `nvidia.ps1` is located

---

## How It Works

1. At logon, the script is executed by Task Scheduler.
2. It creates a `WScript.Shell` object and sends the hotkey to activate NVIDIA Instant Replay.
3. If the service is already disabled, it checks the NVIDIA Overlay log and sends the hotkey again.
4. All actions are logged in `log.txt` for tracking.
