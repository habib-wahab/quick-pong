import QtQuick

Item {
    id: root

    focus: true
    anchors.fill: parent

    required property Player playerOne
    required property Player playerTwo
    required property Timer timer

    property bool keyWPressed: false
    property bool keySPressed: false
    property bool keyUpPressed: false
    property bool keyDownPressed: false

    Keys.onPressed: (event) => {
        switch (event.key) {
            case Qt.Key_W: keyWPressed = true; break;
            case Qt.Key_S: keySPressed = true; break;
            case Qt.Key_Up: keyUpPressed = true; break;
            case Qt.Key_Down: keyDownPressed = true; break;
        }
        event.accepted = true
    }

    Keys.onReleased: (event) => {
        switch (event.key) {
            case Qt.Key_W: keyWPressed = false; break;
            case Qt.Key_S: keySPressed = false; break;
            case Qt.Key_Up: keyUpPressed = false; break;
            case Qt.Key_Down: keyDownPressed = false; break;
        }
        event.accepted = true
    }

    Timer {
        interval: 10
        repeat: true
        running: true
        onTriggered: {
            if (!root.timer.running) {
                return
            }
            if (root.keyWPressed && playerOne.y > 0) {
                root.playerOne.movePaddle(-10);
            }
            if (root.keySPressed && playerOne.y + playerOne.height < parent.height) {
                root.playerOne.movePaddle(10);
            }
            if (root.keyUpPressed && playerTwo.y > 0) {
                root.playerTwo.movePaddle(-10);
            }
            if (root.keyDownPressed && playerTwo.y + playerTwo.height < parent.height) {
                root.playerTwo.movePaddle(10);
            }
        }
    }
}
