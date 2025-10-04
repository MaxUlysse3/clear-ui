import Quickshell.Wayland
import QtQuick
import Quickshell.Hyprland
import Quickshell

WlSessionLock {
	id: lock

	WlSessionLockSurface {
		LockSurface {
			
		}
	}

	// GlobalShortcut {
	// 	id: lockshortcut
	// 	name: "lockscreen"
	// 	description: "Lock the screen"
	// 	onPressed: {
	// 		debug.text = "aaaa";
	// 		lock.locked = true;
	// 	}
	// }
}
