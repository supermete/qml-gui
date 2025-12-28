import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homePage
    anchors.fill: parent

    Rectangle {
        id: header
        anchors.fill: parent
        color: "#00000000"

        Label {
            id: headerTitle
            text: qsTr("Save Page")
            color: "white"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            
        }
    }
}