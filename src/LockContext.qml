import Quickshell
import Quickshell.Services.Pam

Scope {
	id: root
	property string currentText: ""
	property bool unlockInProgress: false
	property bool showFailure: false

	onCurrentTextChanged: showFailure = false

	signal unlocked()
	signal failed()

	function tryUnlock() {
		if (currentText === "") {
			return;
		}
		root.unlockInProgress = true;
		pam.start();
	}

	PamContext {
		id: pam
		config: "quickshell"

		onPamMessage: {
			if (this.responseRequired) {
				this.respond(root.currentText);
			}
		}

		onCompleted: result => {
			if (result === PamResult.Success) {
				root.unlocked();
			} else {
				root.currentText = "";
				root.showFailure = true;
				root.failed();
			}
			root.unlockInProgress = false;
		}
		
	}
}
