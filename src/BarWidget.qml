import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets

Rectangle {
	id: root
	color: "transparent"
	Layout.fillHeight: true
	Layout.preferredWidth: height

	default property list<QtObject> inside
	property IconImage icon
	required property int popupHeight
	required property int popupWidth
	property color popupColor: "#00d679"
	property color popupBorderColor: "#005430"

	HyprlandFocusGrab {
		id: focusGrab
		windows: [ popup ]
		active: false
		onCleared: {
			popupBase.opacity = 0
		}
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: hovered.visible = true
		onExited: hovered.visible = false
		onClicked: {
			popupBase.opacity = 1;
			popup.dep = 0
			focusGrab.active = true
			popup.visible = true
		}
	}

	Rectangle {
		id: hovered
		color: "#330d70"
		anchors.fill: parent
		anchors {
			topMargin: 2
			bottomMargin: 2
			rightMargin: 2
			leftMargin: 2
		}
		radius: 5
		visible: false
	}

	Component.onCompleted: {
		children.push(icon);
	}

	PopupWindow {
		id: popup
		implicitHeight: popupHeight
		implicitWidth: popupWidth
		property int dep: height + 50
		property bool show: false
		anchor {
			id: anc
			item: root
			margins.top: - GeneralSettings.barPopupsSpacing
			adjustment: PopupAdjustment.SlideX
			rect.height: root.height
			rect.width: root.width
			rect.x: root.width - width
			rect.y: - height + dep
		}
		onShowChanged: {
		}

		Behavior on dep {
			NumberAnimation {
				duration: 400
				easing.type: Easing.OutExpo
			}
		}
		visible: false
		color: "transparent"
		Rectangle {
			id: popupBase
			anchors.fill: parent
			radius: 5
			opacity: 0
			visible: true
			color: root.popupColor
			border.width: 3
			border.color: popupBorderColor
			border.pixelAligned: false
			Behavior on opacity {
				PropertyAnimation {
					duration: 100
					onRunningChanged: {
						if (!running && popupBase.opacity < 0.5) {
							popup.visible = false
							popup.dep = popup.height + 50
						}
					}
				}
			}

			children: root.inside
		}
	}
}
