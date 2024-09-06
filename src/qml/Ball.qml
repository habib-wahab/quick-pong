import QtQuick

Image {
    id: root

    property alias timer: ballTimer
	property real horizontalSpeed: parent.width * 0.006;
	property real verticalSpeed: parent.width * 0.006
	property real dimensionRatio: 0.04
	property real speedRatio: 0.006
	property Item playerOne
	property Item playerTwo

    source: "qrc:/pongball.png"
	width: parent.width * dimensionRatio
	height: parent.width * dimensionRatio


    function resetBall() {
        x = (parent.width - width) / 2
        y = (parent.height - height) / 2
        horizontalSpeed = parent.width * speedRatio
        verticalSpeed = parent.height * speedRatio
    }

	transform: Rotation {
		id: ballRotation
		origin.x: width / 2
		origin.y: height / 2
	}

	function handleBallMovement() {
		x += horizontalSpeed
		y += verticalSpeed
	}

	function isCollidingWithPlayerOne() {
		return (x <= playerOne.x + playerOne.width) && (y + height > playerOne.y) && (y < playerOne.y + playerOne.height);
	}

	function isCollidingWithPlayerTwo() {
		return (x + width >= playerTwo.x) && (y + height > playerTwo.y) && (y < playerTwo.y + playerTwo.height);
	}

	function handleCollisionWithPlayers() {
		if (isCollidingWithPlayerOne() && horizontalSpeed < 0) {
			horizontalSpeed = -horizontalSpeed;
			x = playerOne.x + playerOne.width;
		}
		else if (isCollidingWithPlayerTwo() && horizontalSpeed > 0) {
			horizontalSpeed = -horizontalSpeed;
			x = playerTwo.x - width;
		}
	}

	function handleOutOfBoundX() {
		if (x < playerOne.x || x > playerTwo.x) {
			horizontalSpeed = -horizontalSpeed;
		}
		if (x < playerOne.x) {
			playerTwoScore++;
		}
		else if (x > playerTwo.x) {
			playerOneScore++;
		}
	}

	function handleOutOfBoundY() {
		if ((y <= 0) || (y >= parent.height - height)) {
			verticalSpeed = -verticalSpeed;
		}
	}

	Timer {
		id: ballTimer
		interval: 15; running: false; repeat: true
		onTriggered: {
			handleBallMovement()
			handleCollisionWithPlayers()
			handleOutOfBoundX()
			handleOutOfBoundY()
			ballRotation.angle += 1
		}
	}

	function startBallTimer() {
		ballTimer.running = true
	}
}
