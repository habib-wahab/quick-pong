import QtQuick
import QtQuick.Window

Window {
	visible: true
	width: 800
	height: 600
    title: "Ping Pong"
	color: "black"

	property real fontSizeRatio: 0.04
	property int playerOneScore: 0
	property int playerTwoScore: 0

	onWidthChanged: resetBall();
	onHeightChanged: resetBall();

	function resetBall() {
		ball.x = (width - ball.width) / 2
		ball.y = (height - ball.height) / 2
		ball.horizontalSpeed = width * ball.speedRatio
		ball.verticalSpeed = height * ball.speedRatio
	}

	Text {
		id: scoreDisplay
		text: playerOneScore + " - " + playerTwoScore
		font.pixelSize: parent.width * fontSizeRatio
		color: "white"
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.margins: 10
	}

	Player {
		id: playerOne
        paddleColor: "white"
		x: 0
	}

	Player {
		id: playerTwo
        paddleColor: "white"
		x: parent.width - width
	}

	Ball {
		id: ball
		x: (parent.width - width) / 2
		y: (parent.height - height) / 2
		playerOne: playerOne
		playerTwo: playerTwo
	}

	Text {
		id: startText
		text: "Start Game"
		color: "white"
		font.pixelSize: parent.width * fontSizeRatio
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter

		MouseArea {
			anchors.fill: parent
			onClicked: {
				startText.visible = false;
				ball.startBallTimer();
			}
		}
	}
}
