import QtQuick 2.15
import QtQuick.Controls 2.15
import "controls"


ApplicationWindow { // mainWindow
    id: mainWindow
    width: 1000
    height: 600
    visible: true
    color: "#00000000"
    minimumWidth: 500
    minimumHeight: 400

    flags: Qt.FramelessWindowHint | Qt. Window

    property int bgMargins: 10
    property int resizeMargins: 6
    property url maximizeAndRestoreIcon: "../../images/svg/maximize_icon.svg"

    QtObject {
        id: resizeHandles

        function maximizeAndRestore() {
            if (mainWindow.visibility === Window.Maximized) {
                mainWindow.showNormal()
                maximizeAndRestoreIcon = "../../images/svg/maximize_icon.svg"
                bgMargins = 10
            } else {
                mainWindow.showMaximized()
                maximizeAndRestoreIcon = "../../images/svg/restore_icon.svg"
                bgMargins = 0
            }
        }

        function dragControl() {
            mainWindow.startSystemMove()
            if(mainWindow.visibility == Window.Maximized) {                    
                mainWindow.showNormal()
                maximizeAndRestoreIcon = "../../images/svg/maximize_icon.svg"
                bgMargins = 10                    
            }
        }

        /* ---------- Resize Helpers ---------- */

        function resizeLeft(dx) {
            if( mainWindow.width - dx < mainWindow.minimumWidth )
                return
            mainWindow.x += dx
            mainWindow.width -= dx 
        }

        function resizeRight(dx) {
            if( mainWindow.width + dx < mainWindow.minimumWidth )
                return
            mainWindow.width += dx
        }

        function resizeTop(dy) {
            if( mainWindow.height - dy < mainWindow.minimumHeight )
                return
            mainWindow.y += dy
            mainWindow.height -= dy
        }

        function resizeBottom(dy) {
            if( mainWindow.height + dy < mainWindow.minimumHeight )
                return
            mainWindow.height += dy
        }
    }

    /* ---------- Left Edge ---------- */
    MouseArea {
        id: leftMouseArea
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: bgMargins        
        anchors.bottomMargin: bgMargins
        width: bgMargins
        cursorShape: Qt.SizeHorCursor
        property real x0

        onPressed: (mouse) => x0 = mouse.x
        onPositionChanged: (mouse) => resizeHandles.resizeLeft(mouse.x - x0)
    }

    /* ---------- Top-Left Corner ---------- */
    MouseArea { 
        id: topLeftMouseArea
        anchors.top: parent.top
        anchors.left: parent.left
        width: bgMargins
        height: bgMargins
        cursorShape: Qt.SizeFDiagCursor
        property real lastX
        property real lastY

        onPressed: (mouse) => {
            x0 = mouse.x
            y0 = mouse.y
        }
        onPositionChanged: (mouse) => {
            resizeHandles.resizeLeft(mouse.x - x0)
            resizeHandles.resizeTop(mouse.y - y0)
        }
    }

    /* ---------- Right Edge ---------- */
    MouseArea {
        anchors.right: background.right
        anchors.top: background.top
        anchors.bottom: background.bottom
        width: resizeMargins
        cursorShape: Qt.SizeHorCursor
        property real lastX

        onPressed: (mouse) => x0 = mouse.x
        onPositionChanged: (mouse) => resizeHandles.resizeRight(mouse.x - x0)
    }

    /* ---------- Top Edge ---------- */
    MouseArea {
        anchors.top: background.top
        anchors.left: background.left
        anchors.right: background.right
        height: resizeMargins
        cursorShape: Qt.SizeVerCursor
        property real y0

        onPressed: (mouse) => y0 = mouse.y
        onPositionChanged: (mouse) => resizeHandles.resizeTop(mouse.y - y0)
    }

    /* ---------- Bottom Edge ---------- */
    MouseArea {
        anchors.bottom: background.bottom
        anchors.left: background.left
        anchors.right: background.right
        height: resizeMargins
        cursorShape: Qt.SizeVerCursor
        property real y0

        onPressed: (mouse) => y0 = mouse.y
        onPositionChanged: (mouse) => resizeHandles.resizeBottom(mouse.y - y0)
    }

    Rectangle { // background
        id: background 
        anchors.fill: parent
        color: "#2c313c"
        anchors.margins: bgMargins
        border.color: "#383e4c"
        border.width: 1

        Rectangle { // appContainer
            id: appContainer
            anchors.fill: parent
            anchors.margins: 1
            color: "#00000000"

            Rectangle { // topBar
                id: topBar
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 0
                height: 60
                color: "#1c1d20"

                ToggleButton { // toggleButton
                    id: toggleButton
                    width: 70
                    height: 60
                    anchors.left: parent.left
                    anchors.top: parent.top

                    onClicked: {
                        //leftMenuAnimation.running = true
                        leftMenu.width = leftMenu.width == 250 ? 70 : 250
                    }
                }

                Rectangle { // titleBar
                    id: titleBar
                    color: "#00000000"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    height: 35

                    MouseArea {
                        id: titleBarMouseArea
                        anchors.fill: parent
                        onDoubleClicked: {
                            resizeHandles.maximizeAndRestore()
                        }
                    }                    

                    DragHandler {
                        onActiveChanged: if(active) {
                            resizeHandles.dragControl()
                        }
                    }

                    Image { // iconApp
                        id: iconApp
                        width: 28
                        height: 35
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top
                        anchors.leftMargin: 5
                        //source: "moomood.png"
                    }

                    Label { // titleApp
                        id: titleApp
                        text: "Mon Application"
                        anchors.left: iconApp.right
                        anchors.leftMargin: 5
                        color: "#c3cbdd"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row { // windowControls
                    id: windowControls
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    TopButton { // minimizeButton
                        id: minimizeButton
                        width: 35
                        height: 35
                        iconSource: "../../images/svg/minimize_icon.svg"
                        onClicked: {
                            mainWindow.showMinimized()
                        }
                    }

                    TopButton { // maximizeButton
                        id: maximizeButton
                        width: 35
                        height: 35
                        iconSource: maximizeAndRestoreIcon
                        onClicked: resizeHandles.maximizeAndRestore()
                    }

                    TopButton { // closeButton
                        id: closeButton
                        width: 35
                        height: 35
                        iconSource: "../../images/svg/close_icon.svg"
                        hoverColor: "#b23a3a"
                        onClicked: {
                            mainWindow.close()
                        }
                    }
                }

                Rectangle { // topBarDescription
                    id: topBarDescription
                    color: "#282c34"
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 70
                    height: 25

                    Label { // titleBarDescription
                        id: titleBarDescription
                        anchors.left: parent.left
                        anchors.right: parent.right
                        text: "Application description."
                        color: "#5f6a82"
                        anchors.leftMargin: 10
                        anchors.rightMargin: 300
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Label { // shortcuts
                        id: shortcuts
                        anchors.left: titleBarDescription.right
                        anchors.right: parent.right
                        text: "| HOME"
                        color: "#5f6a82"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }

            Rectangle { // content
                id: content
                anchors.top: topBar.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 0
                color: "#00000000"

                Rectangle { // leftMenu
                    id: leftMenu
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: 70
                    color: topBar.color

                    Column {
                        id: columnMenu
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top

                        LeftMenuButton { // homeButton
                            id: homeButton
                            iconSource: "../../images/svg/home_icon.svg"
                            text: qsTr("Accueil")
                            isActive: true
                            onClicked: {
                                homeButton.isActive = true
                                openButton.isActive = false
                                saveButton.isActive = false
                                infoButton.isActive = false
                                settingsButton.isActive = false
                            }
                        }

                        LeftMenuButton { // openButton
                            id: openButton
                            iconSource: "../../images/svg/open_icon.svg"
                            text: qsTr("Ouvrir")
                            onClicked: {
                                homeButton.isActive = false
                                openButton.isActive = true
                                saveButton.isActive = false
                                infoButton.isActive = false
                                settingsButton.isActive = false
                            }
                        }

                        LeftMenuButton { // saveButton
                            id: saveButton
                            iconSource: "../../images/svg/save_icon.svg"
                            text: qsTr("Enregistrer")
                            onClicked: {
                                homeButton.isActive = false
                                openButton.isActive = false
                                saveButton.isActive = true
                                infoButton.isActive = false
                                settingsButton.isActive = false
                            }
                        }

                        LeftMenuButton { // infoButton
                            id: infoButton
                            iconSource: "../../images/svg/info_icon.svg"
                            text: qsTr("Info")
                            onClicked: {
                                homeButton.isActive = false
                                openButton.isActive = false
                                saveButton.isActive = false
                                infoButton.isActive = true
                                settingsButton.isActive = false
                            }
                        }
                    }
                    LeftMenuButton { // settingsButton
                        id: settingsButton
                        iconSource: "../../images/svg/settings_icon.svg"
                        text: qsTr("Paramètres")
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        onClicked: {
                            settingsButton.isActive = true
                            homeButton.isActive = false
                            openButton.isActive = false
                            saveButton.isActive = false
                            infoButton.isActive = false
                        }
                    }
                }

                PropertyAnimation {
                    id: leftMenuAnimation
                    target: leftMenu
                    property: "width"
                    to: leftMenu.width == 250 ? 70 : 250
                    duration: 400
                    easing.type: Easing.InOutQuint
                }

                Rectangle { // contentPages
                    id: contentPages
                    anchors.top: parent.top
                    anchors.left: leftMenu.right
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    color: "#2c313c"
                    anchors.bottomMargin: 25
                }

                Rectangle {
                    id: bottomBar
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.top: contentPages.bottom
                    color: "#282c34"

                    Label {
                        id: labelBottomInfo
                        anchors.left: parent.left
                        anchors.right: parent.right
                        text: "Application Description."
                        color: "#5f6a82"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        anchors.rightMargin: 30
                    }
                }
            }
        }
    }
}