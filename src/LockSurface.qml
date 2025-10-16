import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
	id: root
	color: "#002200"
	visible: true
	anchors.fill: parent

	required property LockContext context

	TextField {
		id: txt
		activeFocusOnTab: true
		anchors.centerIn: parent
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

