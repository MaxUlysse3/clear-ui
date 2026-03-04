pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
	property int angle: 0
	property bool tablet_active: false
	property bool tablet_possible: false
	property int screen_angle: 0
	property bool reversed: false

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
		id: hinges_reader
		running: false
		command: [ "cat", "/sys/bus/iio/devices/iio:device3/in_angl0_raw" ]
		stdout: StdioCollector {
			onStreamFinished: {
				angle = this.text;
				tablet_active = angle >= 200
			}
		}
	}

	Process {
		id: screen_reader
		running: false
		command: [ "cat", "/sys/bus/iio/devices/iio:device3/in_angl1_raw" ]
		stdout: StdioCollector {
			onStreamFinished: {
				screen_angle = this.text;
				if (reversed && screen_angle < 160) {
					reversed = false
				}
				if (!reversed && screen_angle >= 200) {
					reversed = true
				}
			}
		}
	}

	Timer {
		id: clock
		interval: 1000
		repeat: tablet_possible
		running: false
		// triggeredOnStart: true
		onTriggered: {
			hinges_reader.running = true
			screen_reader.running = true
		}
	}
}
