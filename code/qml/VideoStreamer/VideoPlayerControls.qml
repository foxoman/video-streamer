import QtQuick 1.1
import com.nokia.symbian 1.1
import "util.js" as Util

Item {
    id: videoPlayerControls

    width: screen.width
    height: visual.controlAreaHeight


    property bool isPlaying: true
    property int timePlayed: 0
    property int timeRemaining: 0

    signal backButtonPressed
    signal playPressed
    signal pausePressed

    onTimePlayedChanged: {
        timeElapsedLabel.text = Util.milliSecondsToString(timePlayed)
        progressBar.value = timePlayed / (timePlayed + timeRemaining)
    }
    onTimeRemainingChanged: {
        timeRemainingLabel.text = Util.milliSecondsToString(timeRemaining)
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Qt.rgba(0.75, 0.75, 0.75, 0.75)

        Button {
            id: backButton

            text: "<-"
            width: visual.controlWidth
            height: visual.controlHeight
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: visual.controlMargins
            anchors.leftMargin: visual.controlMargins * 2
            onClicked: videoPlayerControls.backButtonPressed()
        }

        Button {
            id: playButton

            text: videoPlayerControls.isPlaying ? "||" : ">"
            width: visual.controlWidth
            height: visual.controlHeight
            anchors.left: backButton.right
            anchors.bottom: parent.bottom
            anchors.margins: visual.controlMargins
            onClicked: {
                if (videoPlayerControls.isPlaying) {
                    videoPlayerControls.pausePressed()
                } else {
                    videoPlayerControls.playPressed()
                }
            }
        }

        Label {
            id: timeElapsedLabel

            text: ""
            anchors.top: playButton.top
            anchors.left: playButton.right
            anchors.margins: visual.controlMargins
        }

        Label {
            id: timeRemainingLabel

            text: ""
            anchors.top: playButton.top
            anchors.right: parent.right
            anchors.margins: visual.controlMargins
        }

        ProgressBar {
            id: progressBar

            anchors.top: timeElapsedLabel.bottom
            anchors.left: playButton.right
            anchors.right: timeRemainingLabel.right
            anchors.margins: visual.controlMargins
        }
    }
}
