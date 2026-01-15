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

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter

    }

}