import Quickshell
import QtQuick
import QtQml.Models
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 6
	layoutDirection: Qt.LeftToRight
	uniformCellSizes: false

	Repeater {
		id: father
		model: Hyprland.workspaces

		Rectangle {
			visible: modelData.id >= 0
			// visible: false
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
				// text: test(modelData.name, "/special:/")
				anchors.centerIn: parent
			}
		}
	}

	WorkspaceSwitcher {
		Layout.fillHeight: true
		Layout.topMargin: 3
		Layout.bottomMargin: 3
	}

	ScreenRotator {
		Layout.fillHeight: true
		Layout.topMargin: 3
		Layout.bottomMargin: 3
	}

	Indicators {
		Layout.fillHeight: true
		Layout.topMargin: 3
		Layout.bottomMargin: 3
	}
}
