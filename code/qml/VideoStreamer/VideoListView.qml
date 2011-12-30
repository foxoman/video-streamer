import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: mainPage

    function forceKeyboardFocus() {
        listView.forceActiveFocus();
    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            mainPage.forceKeyboardFocus();
        }
    }

    // Background, shown behind the lists.
    Image {
        id: backgroundImg
        anchors.fill: parent
        source: visual.inPortrait ? visual.images.portraitBackground
                                  : visual.images.landscapeBackground
    }

    ListView {
        id: listView
        anchors.fill: parent
        snapMode: ListView.SnapToItem

        model: xmlDataModel
        focus: true
        cacheBuffer: visual.videoListItemHeight*10

        // List item delegate Component.
        delegate: VideoListItem {
            width: listView.width
        }

        // Single header delegate Component.
        header: TitleBar {
            id: titleBar

            height: visual.titleBarHeight
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    ScrollDecorator {
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        // flickableItem binds the scroll decorator to the ListView.
        flickableItem: listView
    }

    Loader {
        anchors.centerIn: parent
        height: visual.busyIndicatorHeight
        width: visual.busyIndicatorWidth
        sourceComponent: listView.model.loading ? busyIndicator : undefined

        Component {
            id: busyIndicator

            BusyIndicator {
                running: true
            }
        }
    }
}
