import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
	color: "#00000000"
	visible: true
	anchors.fill: parent

	required property LockContext context

	TextField {
		id: txt
		anchors.centerIn: parent
		echoMode: TextInput.Password
		font.pixelSize: 12
		font.family: "Ubuntu"
		implicitHeight: 50
		implicitWidth: 500

		enabled: !context.unlockInPreogress
		onTextEdited: context.currentText = this.text
		onAccepted: {
			context.tryUnlock()
		}
	}

	Button {
		visible: true
		text: "unlock"
		onClicked: lock.locked = false
	}
}

