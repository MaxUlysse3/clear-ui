pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
	property int angle: 0
	property bool tablet_active: false
	property bool tablet_possible: false

	Process {
		id: file_exists
		running: true
		command: [ "sh", "-c", "test -f /sys/bus/iio/devices/iio:device3/in_angl0_raw && echo true || echo false" ]
		stdout: StdioCollector {
			onStreamFinished: {
				tablet_possible = this.text;
				clock.running = tablet_possible;
			}
		}
	}

	Process {
		id: reader
		running: false
		command: [ "cat", "/sys/bus/iio/devices/iio:device3/in_angl0_raw" ]
		stdout: StdioCollector {
			onStreamFinished: {
				angle = this.text;
				tablet_active = angle >= 200
			}
		}
	}

	Timer {
		id: clock
		interval: 1000
		repeat: tablet_possible
		running: false
		// triggeredOnStart: true
		onTriggered: reader.running = true
	}
}
