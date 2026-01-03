import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: detailsView
    property string taskName: ""

    Rectangle {
        id: pageContent
        anchors.fill: parent
        anchors.bottomMargin: 30
        color: "#2c313c"
    Label {
            id: title
            text: qsTr(taskName)
            color: "white"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Rectangle {
        id: footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: pageContent.bottom
        color: '#2c313c'

        Label {
            id: footerText
            text: qsTr("< Retour")
            color: '#004bd7'
            font.bold: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    stackView.pop()
                }
            }
        }
    }
}