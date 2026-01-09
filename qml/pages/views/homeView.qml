import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homeView

    Rectangle {
        id: pageContent
        anchors.fill: parent
        anchors.bottomMargin: 30
        color: "#2c313c"

        ListView {
            id: taskListView
            anchors.fill: parent
            anchors.margins: 10
            model: todoModel

            delegate: Rectangle {
                width: taskListView.width
                height: 50
                color: index % 2 === 0 ? "#3a3f4a" : "#343a45"
                radius: 10
                border.color: "#1e222a"
                border.width: 1

                Text {
                    id: taskName
                    text: display
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
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
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            stackView.push("detailsView.qml", { taskName: display } )
                        }
                }
            }
        }
    }
}