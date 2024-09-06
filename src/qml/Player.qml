import QtQuick
import quickpong.player

PlayerTouchHandler {
	property color paddleColor

	width: parent.width * 0.03
	height: parent.height * 0.2
	y: (parent.height - height) / 2
    focus: true

	Rectangle {
		id: paddle
		anchors.fill: parent
		color: parent.paddleColor
	}

	Behavior on y {
		SmoothedAnimation { duration: 100 }
	}
}
