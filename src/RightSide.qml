import QtQuick.Layouts
import QtQuick

RowLayout {
	layoutDirection: Qt.RightToLeft
	
	VolumeWidget {
		
	}

	BarWidget {
		popupHeight: 500
		popupWidth: 20

		inside: [ 
			Rectangle {
				implicitHeight: 50
				implicitWidth: 100
				color: "blue"
				anchors.centerIn: parent
			}
		]
	}
	
}
