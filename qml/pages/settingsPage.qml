import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homePage

    Rectangle {
        id: pageContent
        anchors.fill: parent
        color: "#2c313c"

        Label {
            id: title
            text: qsTr("Settings Page")
            color: "white"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            
        }
    }
}