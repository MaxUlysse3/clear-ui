import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell
import QtQuick
import QtQml

PopupWindow {
	id: root
	anchor.window: barWindow
	anchor.rect.x: barWindow.width / 2 - width / 2
	anchor.rect.y: - barWindow.height - 100
	visible: frame.visible
	implicitHeight: 50
	implicitWidth: 200
	color: "transparent"

	Rectangle {
		id: frame
		visible: timer.running
		color: "#bb555555"
		radius: height / 2
		border.width: 2
		border.color: "black"
		anchors.fill: parent
		Rectangle {
			color: "#666666"
			radius: height / 2
			anchors.centerIn: parent
			implicitHeight: 5
			implicitWidth: 140
			Rectangle {
				color: if (Pipewire.defaultAudioSink.audio.muted) {
					"red"
				} else {
					"white"
				}
				radius: height / 2
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				implicitWidth: parent.width * Pipewire.defaultAudioSink.audio.volume
			}
		}
	}

	Timer {
		id: timer
		interval: 1000
		repeat: false
		// running: true
	}

	PwObjectTracker {
		id: tracker
		objects: [ Pipewire.defaultAudioSink ]
	}

	Component.onCompleted: {
		Pipewire.defaultAudioSink.audio.onVolumeChanged.connect(showWindow)
	}

	Connections {
		target: Pipewire.defaultAudioSink.audio
		function onVolumeChanged() {
			root.showWindow()
		}
		function onMutedChanged() {
			root.showWindow()
		}
	}

	function showWindow() {
		timer.restart()
	}
}
