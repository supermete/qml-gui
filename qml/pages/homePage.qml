import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homePage

    Rectangle {
        id: header
        anchors.fill: parent
        color: "#2c313c"

        Label {
            id: headerTitle
            text: qsTr("Home Page")
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
}