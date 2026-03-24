import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

RowLayout {
	id: indicators
	spacing: 0
	uniformCellSizes: true
	layoutDirection: Qt.LeftToRight

	readonly property int cellWidth: 8

	// Touchscreen enabled
	Rectangle {
		id: touch_enable
		Layout.fillHeight: true
		Layout.preferredWidth: indicators.cellWidth
		color: "transparent"
		visible: true
		radius: this.width

		readonly property bool tablet: TabletSensors.tablet_active

		onTabletChanged: if (TabletSensors.tablet_possible) {
			if (!tablet) {
				enable_touch.running = true
			}
		}

		// Enables the touchscreen back
		Process {
			id: enable_touch
			running: false
			command: [ "hyprctl", "keyword input:touchdevice:enabled true" ]
			// stdout: StdioCollector {
			// 	onStreamFinished: {
			// 		console.log(this.text)
			// 	}
			// }
		}

		Process {
			id: get_state
			running: false
			command: [ "hyprctl", "getoption input:touchdevice:enabled" ]
			stdout: StdioCollector {
				onStreamFinished: {
					const txt = this.text;
					const regex = /int: ./;
					const val = regex.exec(txt)[0].slice(-1);
					if (val === "0") {
						touch_enable.color = "#e04747";
					} else {
						touch_enable.color = "transparent";
					}
				}
			}
		}

		Timer {
			id: poll_state
			interval: 500
			repeat: true
			running: true
			onTriggered: get_state.running = true
		}
	}
	
}
