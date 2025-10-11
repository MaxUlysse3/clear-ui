import Quickshell.Wayland
import QtQuick
import Quickshell.Hyprland
import Quickshell

Scope {
	LockContext {
		id: lcontext
		onUnlocked: lock.locked = false
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

	GlobalShortcut {
		id: lockshortcut2
		name: "lockscreen"
		description: "Lock the screen"
		onPressed: {
			lock.locked = true;
		}
	}
}
