import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homeView

    SwipeView {
        id: view
        anchors.fill: parent
        currentIndex: 0

        IncompleteTasksView {
            id: incompleteTasksView
        }

        CompleteTasksView {
            id: completeTasksView
        }
    }

    Rectangle {
        id: indicatorBackground
        width: parent.width
        height: 30
        anchors.bottom: view.bottom
        color: "#2c313c"
        
        PageIndicator {
            id: pageIndicator

            count: view.count
            currentIndex: view.currentIndex
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
        }
    }
}