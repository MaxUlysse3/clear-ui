import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

BarWidget {
	Slider {
		PwObjectTracker {
			objects: [ Pipewire.defaultAudioSink ]
		}
		id: control
		from: 0
		to: 100
		orientation: Qt.Vertical
		implicitWidth: 10
		anchors.centerIn: parent
		anchors.topMargin: 20
		anchors.bottomMargin: 20
		value: Pipewire.defaultAudioSink.audio.volume * 100
		onMoved: Pipewire.defaultAudioSink.audio.volume = value / 100

		handle: Rectangle {
			x: control.leftPadding + control.availableWidth / 2 - width / 2
			y: control.topPadding + control.visualPosition * (control.availableHeight - height)
			implicitHeight: 14
			implicitWidth: height
			radius: height / 2
			color: "#00b7a2"
			border.width: 1
			border.color: "#007c6e"
		}

		background: Rectangle {
			x: control.leftPadding
			y: control.topPadding
			implicitWidth: 10
			implicitHeight: 260
			radius: width
			color: "#00967a"

			Rectangle {
				implicitHeight: (1 - control.visualPosition) * parent.height
				anchors {
					bottom: parent.bottom
					left: parent.left
					right: parent.right
				}
				radius: 5
				color: "#315df9"
			}
		}
	}

	popupHeight: 300
	popupWidth: 50
	icon: IconImage {
		source: "file://" + Quickshell.shellPath("assets/volume-icon.png")
		anchors.fill: parent
		anchors.topMargin: 2
		anchors.bottomMargin: 2
		anchors.leftMargin: 2
		anchors.rightMargin: 2
	}

}
