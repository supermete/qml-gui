import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homeView

    Rectangle {
        id: pageContent
        anchors.fill: parent
        anchors.bottomMargin: 30
        color: "#2c313c"

        Label {
                id: title
                text: qsTr("Home View")
                color: "white"
                font.pixelSize: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        TextField {
            id: testField
            width: parent.width * 0.6
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            placeholderText: qsTr("Ecrire un texte...")
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
            text: qsTr("Details >")
            color: '#004bd7'
            font.pixelSize: 14
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.rightMargin: 10

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    stackView.push("detailsView.qml")
                }
            }
        }
    }
}