import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: homePage

    Rectangle {
        id: pageContent
        anchors.fill: parent
        color: "#2c313c"
        clip: true

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: "views/homeView.qml"
        }
    }
    
}