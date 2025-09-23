import Quickshell
import QtQuick
import Quickshell.Io

Scope {
	id: root

	PanelWindow {
		id: barWindow
		anchors {
			bottom: true
			left: true
			right: true
		}

		margins {
			left: 20
			right: 20
		}

		implicitHeight: 30

		color: "transparent"

		Rectangle {
			anchors.fill: parent
			radius: 15
			border.color: "black"
			border.width: 1
			color: "#665c5c5c"

			ClockWidget {
				id: clock
				anchors.centerIn: parent
			}

			HyprWorkspaces {
				anchors {
					left: parent.left
					top: parent.top
					bottom: parent.bottom
					leftMargin: 3
				}
			}

			// RightSide {
			// 	// anchors.centerIn: parent
			// 	// implicitHeight: 50
			// 	anchors {
			// 		right: parent.right
			// 		top: parent.top
			// 		bottom: parent.bottom
			// 		rightMargin: 3
			// 	}
			// }
		}

		Volume {
		}
	}
}
