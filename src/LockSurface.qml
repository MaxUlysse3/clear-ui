import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
	id: root
	color: "#002200"
	visible: true
	anchors.fill: parent

	required property LockContext context

	SystemClock {
		id: time
		precision: SystemClock.Minutes
	}

	ColumnLayout {
		anchors.centerIn: parent
		layoutDirection: Qt.TopToBottom
		spacing: 10

		Text {
			Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
			color: "blue"
			text: Qt.formatDateTime(time.date, "hh:mm")
			font.pixelSize: 40
		}

		TextField {
			id: txt
			Layout.preferredHeight: 50
			Layout.preferredWidth: 500
			Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
			activeFocusOnTab: true
			// anchors.centerIn: parent
			echoMode: TextInput.Password
			font.pixelSize: 12
			font.family: "Ubuntu"
			implicitHeight: 50
			implicitWidth: 500

			enabled: !context.unlockInProgress
			onTextEdited: context.currentText = this.text
			onAccepted: {
				context.tryUnlock()
			}
			background: Rectangle {
				color: "red"
			}
		}
	}

	

	Connections {
		target: root.context

		function onCurrentTextChanged() {
			txt.text = root.context.currentText
		}
	}

	Button {
		visible: false
		text: "unlock"
		onClicked: lock.locked = false
	}
}

