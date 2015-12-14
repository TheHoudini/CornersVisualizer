import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import corners.objects 1.0

ApplicationWindow {
    id: main



    property bool isDesktop : Qt.platform.os == "linux" || Qt.platform.os == "osx" || Qt.platform.os == "windows"

    width: !isDesktop ? Screen.desktopAvailableWidth : Units.dp(800)
    height: !isDesktop ? Screen.desktopAvailableHeight : Units.dp(600)


    property var logs : []
    property var selectedLog : ({})
    title: "Визуализатор"

    // Necessary when loading the window from C++
    visible: true

    //object with bridged data(c++)
    Bridge {
        id : bridge
    }

    Component.onCompleted: {
        logs = bridge.getArray("logs")
        if(logs.length === 0)
        {
            logs.push(bridge.getJsonFromFile(":/qml/modules/seafight/log/log.log"))
            logs.push(bridge.getJsonFromFile(":/qml/modules/corners/log/Corners.log"))
            logs = logs
        }
        pageStack.push(page)
    }


    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["red"]["A200"]
        tabHighlightColor: "white"
    }



     TabbedPage {
        id: page

        title: "Визуализатор"

        actionBar.maxActionCount: 3

        property var previewBlockObject
        actions: [

            Action {
                iconName : "content/add"
                name : "Добавить лог"
                onTriggered: logPicker.show()
            },

            Action {
                iconName: "image/color_lens"
                name: "Выбрать цвета"
                onTriggered: colorPicker.show()
            },

            Action {
                iconName: "action/settings"
                name: "Настройки"
                hoverAnimation: true
            }
        ]


        backAction: navDrawer.action

        NavigationDrawer {
            id: navDrawer

            enabled: main.width < Units.dp(700)

            Flickable {
                anchors.fill: parent

                contentHeight: Math.max(content.implicitHeight, height)

                Column {
                    id: content
                    anchors.fill: parent
                    Repeater{
                        id : testRepeator
                        model : main.logs
                        ListItem.Subtitled {
                            text: logs[index].launchId
                            subText: logs[index].gameDate
                            selected: selectedLog === logs[index]
                            onClicked:     {
                                selectedLog = logs[index]
                                page.loadPreviewBlock(selectedLog)
                                navDrawer.close()
                            }
                        }
                    }
                }
            }
        }





        Sidebar {
            id: sidebar

            expanded: !navDrawer.enabled

            Column {
                width: parent.width


                Repeater{
                    model : main.logs
                    ListItem.Subtitled {
                        text: logs[index].launchId
                        subText: logs[index].gameDate
                        selected: selectedLog === logs[index]
                        onClicked:     {
                            selectedLog = logs[index]
                            page.loadPreviewBlock(selectedLog)
                        }
                    }
                }
            }
        }

        Loader{
            id : previewPageLoader
            anchors {
                left: sidebar.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 14
            }

            visible : status == Loader.Ready
            asynchronous: true

            // обработка сигналов динамически подгруженного блока превью
            onLoaded: {
                previewConnector.target = item
                item.open(0,0)
            }
            Connections {
                id : previewConnector
                ignoreUnknownSignals: true
                onVisualizeTriggered : pageStack.push(fieldComponent)
            }

        }


        function loadPreviewBlock(log)
        {
            previewPageLoader.setSource("modules/" + log.game.toLowerCase() + "/Preview.qml",{"log": log})
        }


        ProgressCircle {
            id: loadProgress
            visible: previewPageLoader.status == Loader.Loading
            width: Units.dp(64)
            height: Units.dp(64)
            anchors.centerIn: previewPageLoader
            dashThickness: Units.dp(8)


        }
    }


    Dialog {
            id: colorPicker
            title: "Pick color"

            property var primaryColor
            property var accentColor
            property var backgroundColor
            positiveButtonText: "Done"

            onOpened: {
                primaryColor = theme.primaryColor
                accentColor = theme.accentColor
                backgroundColor = theme.backgroundColor
            }

            MenuField {
                id: selection
                model: ["Primary color", "Accent color", "Background color"]
                width: Units.dp(160)
            }

            Grid {
                columns: 7
                spacing: Units.dp(8)

                Repeater {
                    model: [
                        "red", "pink", "purple", "deepPurple", "indigo",
                        "blue", "lightBlue", "cyan", "teal", "green",
                        "lightGreen", "lime", "yellow", "amber", "orange",
                        "deepOrange", "grey", "blueGrey", "brown", "black",
                        "white"
                    ]

                    Rectangle {
                        width: Units.dp(30)
                        height: Units.dp(30)
                        radius: Units.dp(2)
                        color: Palette.colors[modelData]["500"]
                        border.width: modelData === "white" ? Units.dp(2) : 0
                        border.color: Theme.alpha("#000", 0.26)

                        Ink {
                            anchors.fill: parent

                            onPressed: {
                                switch(selection.selectedIndex) {
                                    case 0:
                                        theme.primaryColor = parent.color
                                        break;
                                    case 1:
                                        theme.accentColor = parent.color
                                        break;
                                    case 2:
                                        theme.backgroundColor = parent.color
                                        break;
                                }
                            }
                        }
                    }
                }
            }

            onRejected: {
                // TODO set default colors again but we currently don't know what that is
                theme.primaryColor = primaryColor
                theme.accentColor = accentColor
                theme.backgroundColor = backgroundColor
            }
        }



    Snackbar {
        id: snackbar
    }
    Dialog {
            id : logPicker
            property string filePath
            property var log
            onFilePathChanged: {
                if(!filePath) return;
                var tmp =  bridge.getJsonFromFile(filePath)
                if(tmp.game && (tmp.game.toLowerCase() === "seafight" || tmp.game.toLowerCase() === "corners"))
                {
                    snackbar.open("Корректный лог, имя игры : " + (tmp.game.toLowerCase() === "seafight"  ? "Морской бой" : "Уголки")  )
                    pathLbl.text = filePath
                    log = tmp
                }else{
                    filePath = ""
                    log = ""
                    snackbar.open("Некорректный лог")
                }

            }
            MenuField {
                id: logType
                Layout.fillWidth: true
                model: ["Файл", "Ссылка"]
                width: parent.width
            }
            onAccepted: {
                if(log)
                {
                    logs.push(new Object(log))
                    bridge.setArray("logs",logs)
                    filePath = ""
                    log = undefined
                    logs = logs
                }
            }

            RowLayout{
                anchors.left: parent.left
                anchors.right: parent.right
                Label {
                    id : pathLbl
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    text: "Выберите файл"
                }
                Button{
                    id : pathBtn
                    text: "Выбрать"
                    onClicked: logPicker.filePath = bridge.getFilePath()
                }
            }

        }



        // component for push to the stack view
        Component {
            id : fieldComponent
            TabbedPage {

                property var log : selectedLog
                id: page
                title : log.launchId

                property var _fieldObj
                property var _controlObj

                property bool isLoaded : fieldViewLoader.status === Loader.Ready && bottomSheetLoader.status === Loader.Ready
                onIsLoadedChanged: {
                    if(!isLoaded)return
                    waveAnimation.open(14,14)
                    bottomSheetLoader.item.fieldObj = fieldViewLoader.item
                    page.actions = bottomSheetLoader.item.actionList
                    if(_controlObj.init) _controlObj.init()
                }

                onLogChanged: {
                    page.title = log.launchId
                    fieldViewLoader.setSource("modules/" + log.game.toLowerCase()+ "/Field.qml",{"fieldLog" : log})
                    bottomSheetLoader.setSource("modules/" + log.game.toLowerCase()+ "/Control.qml")
                }




                View{
                    elevation: 0
                    anchors.fill: parent
                    anchors.margins: 14
                    id : fieldView

                    Wave{
                        id : waveAnimation
                        onFinished: {
                            visible = false
                            fieldViewLoader.visible = true
                        }
                    }
                    Loader{
                        visible: false
                        id : fieldViewLoader
                        asynchronous: true
                        anchors.fill: parent
                    }
                    ProgressCircle {
                        visible: fieldViewLoader.status == Loader.Loading
                        width: parent.width/2
                        height: parent.height/2
                        anchors.centerIn: parent
                        dashThickness: Units.dp(8)


                    }

                }
                BottomSheet {
                    id: bottomSheet
                    maxHeight: main.height/3
                    height : main.height/4 * 2
                    Loader{
                        id : bottomSheetLoader
                        visible: isLoaded
                        anchors.fill: parent
                        asynchronous: true
                    }

                    Connections{
                        ignoreUnknownSignals: true
                        target : bottomSheetLoader.status === Loader.Ready ? bottomSheetLoader.item : 0
                        onOpenRequest : bottomSheet.open()
                    }
                }


            }
        }



}


