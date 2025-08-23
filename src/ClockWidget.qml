import QtQuick
import Quickshell

Text {
	SystemClock {
		id: time
		precision: SystemClock.Seconds
	}

	text: Qt.formatDateTime(time.date, "hh:mm:ss - dd/MM/yyyy")
}
