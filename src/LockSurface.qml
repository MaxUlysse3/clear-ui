import QtQuick
import QtQuick.Controls

Rectangle {
	color: "#99000000"
	visible: true
	anchors.fill: parent

	Button {
		text: "unlock"
		onClicked: lock.locked = false
	}
}

