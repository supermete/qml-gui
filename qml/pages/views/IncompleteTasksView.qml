import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: incompleteTasksView

    Rectangle {
        id: pageContent
        anchors.fill: parent
        anchors.bottomMargin: 30
        color: "#2c313c"

        ListView {
            id: incompleteTasksListView
            anchors.fill: parent
            anchors.margins: 10
            model: proxyModelIncompleteTasks
            reuseItems: false

            remove: Transition {
                NumberAnimation {
                    properties: "x"
                    to: incompleteTasksListView.width
                    duration: 250
                    easing.type: Easing.InCubic
                }
            }

            displaced: Transition {
                SequentialAnimation {
                    PauseAnimation { duration: 250 }
                    NumberAnimation {
                        property: "y"
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }

            delegate: Rectangle {
                width: incompleteTasksListView.width
                height: 50
                color: index % 2 === 0 ? "#3a3f4a" : "#343a45"
                radius: 10
                border.color: "#1e222a"
                border.width: 1

                CheckBox {
                    id: taskCheckbox
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    checked: completed
                    onClicked: {
                        completed = checked
                    }
                }
                Text {
                    id: taskName
                    text: display
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: taskCheckbox.right
                    anchors.leftMargin: 15
                    anchors.right: arrowIcon.left
                    color: "white"
                    font.pixelSize: 15
                }
                Text {
                    id: arrowIcon
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    text: ">"
                    color: "white"
                    font.pixelSize: 15
                }
                MouseArea {
                        anchors.left: taskName.left
                        anchors.right: arrowIcon.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            stackView.push("detailsView.qml", { taskName: display } )
                        }
                }
            }
        }
    }
}