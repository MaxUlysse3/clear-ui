import Quickshell
import QtQuick
import QtQml.Models
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 6
	layoutDirection: Qt.LeftToRight
	uniformCellSizes: true

	Repeater {
		id: father
		model: Hyprland.workspaces

		Rectangle {
			visible: modelData.id !== -99
			radius: width / 2
			Layout.fillHeight: true
			Layout.preferredWidth: height
			Layout.topMargin: 3
			Layout.bottomMargin: 3
			color: {
				if (modelData.active) {
					return "#9c9c9c";
				} else {
					return "transparent"
				}
			}

			border {
				color: "black"
				width: 2
			}

			Text {
				text: modelData.name
				// text: "p"
				anchors.centerIn: parent
			}
		}
	}

	Rectangle {
		Layout.fillHeight: true
		Layout.preferredWidth: height
		Layout.topMargin: 3
		Layout.bottomMargin: 3

		radius: height / 2
		color: "transparent"


		border {
			color: "lime"
			width: 2
		}

		Text {
			text: "+"
			anchors.centerIn: parent
			color: "lime"
		}

		visible: (Hyprland.focusedWorkspace.id === -99)
	}
}
