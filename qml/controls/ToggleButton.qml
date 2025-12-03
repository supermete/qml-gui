import QtQuick 2.15
import QtQuick.Controls 2.15

Button { // toggleButton
    id: toggleButton

    property url iconSource: "../../images/svg/menu_icon.svg"
    property color hoverColor: "#2c313c"
    property color pressedColor: "#383e4c"
    property color normalColor: "#1c1d20"
    
    QtObject {
        id: buttonColor

        property color currentColor: if(toggleButton.pressed) {
            toggleButton.pressedColor
        } else if(toggleButton.hovered) {
            toggleButton.hoverColor
        } else {
            toggleButton.normalColor
        }
    }

    font.pixelSize: 24
    implicitWidth: 100
    implicitHeight: 35

    background: Rectangle {
        color: buttonColor.currentColor
    }

    contentItem: Item {
        anchors.fill: parent
        Image {
            id: buttonIcon
            source: iconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 16
            fillMode: Image.PreserveAspectFit
        }
    }
    onClicked: {
        console.log("Toggle button clicked")
    }
}

