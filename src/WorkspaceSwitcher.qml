import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Hyprland


Rectangle {
	readonly property bool active: TabletSensors.tablet_active

	visible: active
	color: "transparent"
	radius: height
	border.color: "#555555"
	border.width: 2
	implicitWidth: 150

	MouseArea {
		id: mouse
	
		function swipedLeft() {
			var act = Hyprland.focusedWorkspace.id;
			var next = act == 1 ? 10 : act - 1
			Hyprland.dispatch(`workspace ${next}`)
		}

		function swipedRight() {
			var act = Hyprland.focusedWorkspace.id;
			var next = act == 10 ? 1 : act + 1
			Hyprland.dispatch(`workspace ${next}`)
		}

		property real beganOnX

		enabled: active
		anchors.centerIn: parent
		implicitWidth: parent.width
		implicitHeight: parent.height + 10

		onPressed: (mouse) => beganOnX = mouse.x
		onReleased: (mouse) => {
			var endedOnX = mouse.x;
			var mid = this.width / 2;
			if (endedOnX >= mid && beganOnX < mid) {
				swipedRight()
			} else if (endedOnX < mid && beganOnX >= mid) {
				swipedLeft()
			}
		}
	}

	Text {
		id: label
		// text: sensors.angle
	}


}
