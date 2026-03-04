import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Hyprland
import QtQuick.Controls

Rectangle {
	id: root
	readonly property bool active: TabletSensors.tablet_active
	// readonly property bool active: true
	readonly property bool reversed: TabletSensors.reversed
	property bool auto_rotate: false
	property int rotationState: 0

	visible: active
	implicitWidth: height
	color: "transparent"
	radius: height / 2
	border.color: auto_rotate ? "#1dba01" : "#555555"
	// border.color: "#1dba01"
	border.width: 2

	function rotate() {
		var scale = Hyprland.focusedMonitor.scale
		// var cmds = [[ "hyprctl", `keyword monitor ,preferred, auto, 1, transform, ${rotationState}` ],
		// 	["hyprctl", `keyword input:tablet:transform ${rotationState}`],
		// 	["hyprctl", `keyword input:touchdevice:transform ${rotationState}`]
		// ]
		// for (const c of cmds) {
		// 	console.log(c)
		// 	rotator.command = c
		// 	rotator.running = true
		// }
		screenRotator.command = [ "hyprctl", `keyword monitor ,preferred, auto, ${scale}, transform, ${rotationState}` ]
		tabletRotator.command = ["hyprctl", `keyword input:tablet:transform ${rotationState}`]
		touchdeviceRotator.command = ["hyprctl", `keyword input:touchdevice:transform ${rotationState}`]

		screenRotator.running = true
		tabletRotator.running = true
		touchdeviceRotator.running = true
	}

	onActiveChanged: {
		auto_rotate = false
		rotationState = 0
		rotate()
	}

	onReversedChanged: {
		if (auto_rotate) {
			if (reversed) {
				rotationState = 2
				rotate()
			} else {
				rotationState = 0
				rotate()
			}
		}
	}

	Process {
		id: touchdeviceRotator
		running: false
		// stdout: StdioCollector {
		// 	onStreamFinished: {
		// 		console.log(this.text)
		// 	}
		// }
	}

	Process {
		id: tabletRotator
		running: false
		// stdout: StdioCollector {
		// 	onStreamFinished: {
		// 		console.log(this.text)
		// 	}
		// }
	}

	Process {
		id: screenRotator
		running: false
		// stdout: StdioCollector {
		// 	onStreamFinished: {
		// 		console.log(this.text)
		// 	}
		// }
	}

	MouseArea {
		id: mouse
		enabled: active
		anchors.centerIn: parent
		implicitHeight: parent.height + 6
		implicitWidth: parent.width + 6
		// implicitHeight: 30
		// implicitWidth: 30
		hoverEnabled: true

		ElapsedTimer {
			id: begTimer
		}

		ElapsedTimer {
			id: lastTimer
		}

		function singleClick() {
			// root.color = "yellow"
			if (auto_rotate) {
				auto_rotate = false
			} else if (parent.rotationState == 0) {
				parent.rotationState = 2
				parent.rotate()
			} else {
				parent.rotationState = 0
				parent.rotate()
			}
		}

		function doubleClick() {
			// parent.color = "purple"
			parent.rotationState = 1
			parent.rotate()
		}

		function longClick() {
			// parent.color = "green"
			auto_rotate = auto_rotate ? false : true
			if (auto_rotate) {
				reversedChanged()
			}
		}

		Timer {
			id: notDouble
			interval: 200
			repeat: false
			running: false
			onTriggered: mouse.singleClick()
		}

		onPressed: begTimer.restart()
		onReleased: (ev) => {
			var t = begTimer.elapsedMs()
			var last = lastTimer.restartMs()
			if (t >= 1000) {
				mouse.longClick()
			} else if (last < 200){
				notDouble.running = false
				mouse.doubleClick()
			} else {
				notDouble.restart()
			}
		}
	}

	// Text {
	// 	id: label
	// 	text: TabletSensors.angle
	// }
}
