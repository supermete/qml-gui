import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects

Button { // leftMenuButton
    id: leftMenuButton

    text: qsTr("Left Menu Button")
    property url iconSource: "../../images/svg/home_icon.svg"
    property color hoverColor: "#2c313c"
    property color pressedColor: "#383e4c"
    property color normalColor: "#1c1d20"
    property int iconWidth: 16
    property int iconHeight: 16
    property bool isActive: true
    property color activeMenuColor: "#0059b8"
    
    QtObject {
        id: buttonColor

        property color currentColor: if(leftMenuButton.pressed) {
            leftMenuButton.pressedColor
        } else if(leftMenuButton.hovered) {
            leftMenuButton.hoverColor
        } else {
            leftMenuButton.normalColor
        }
    }

    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle {
        color: buttonColor.currentColor

        Rectangle {
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: 3
            color: activeMenuColor
            visible: leftMenuButton.isActive
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Image {
            id: buttonIcon
            source: iconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 26
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        MultiEffect {
            id: iconOverlay
            anchors.fill: buttonIcon
            source: buttonIcon
            colorizationColor: "#ffffff"
            colorization: 1.0
            brightness: 1.0
        }

        Text {
            id: buttonText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: buttonIcon.right
            anchors.leftMargin: 50
            font: leftMenuButton.font
            text: leftMenuButton.text
            color: "#ffffff"
        }
    }
}