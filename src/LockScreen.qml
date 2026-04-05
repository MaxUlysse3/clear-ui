import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQml
import Quickshell.Hyprland
import Quickshell

Scope {
	LockContext {
		id: lcontext
		onUnlocked: {
			lock.locked = false
			dpms_timer.running = false
		}
	}

	Text {
		id: debug
		text: "toto"
	}

	WlSessionLock {
		id: lock

		WlSessionLockSurface {
			LockSurface {
				context: lcontext
			}
		}



	}

	Process {
		id: dpms_off
		command: [ "hyprctl", "dispatch dpms off" ]
		running: false
	}

	Timer {
		id: dpms_timer
		interval: 10000
		repeat: false
		running: false
		onTriggered: dpms_off.running = true
	}

	GlobalShortcut {
		id: lockshortcut2
		name: "lockscreen"
		description: "Lock the screen"
		onPressed: {
			lock.locked = true;
			dpms_timer.running = true;
		}
	}
}
