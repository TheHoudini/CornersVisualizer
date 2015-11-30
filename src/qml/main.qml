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
    title: "Визуализатор уголков"

    // Necessary when loading the window from C++
    visible: true


    //object with bridged data(c++)
    Bridge {
        id : bridge
    }

    Component.onCompleted: {
        var log = bridge.getJsonFromFile("e:/Corners.log")
        logs.push(log)


        log = bridge.getJsonFromFile("e:/SeaBattle.log")
        logs.push(log)
        // push don't emit notification abous changing property
        // but rewrite do
        logs = logs
    }


    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["red"]["A200"]
        tabHighlightColor: "white"
    }



    initialPage: TabbedPage {
        id: page

        title: "Визуализатор уголков"

        actionBar.maxActionCount: 3

        property var previewBlockObject
        actions: [

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
            onLoaded:  previewConnector.target = item
            Connections {
                id : previewConnector
                ignoreUnknownSignals: true
                onVisualizeTriggered : stackLoader.sourceComponent = fieldComponent
            }

        }


        function loadPreviewBlock(log)
        {
            previewPageLoader.setSource("modules/" + log.gameName + "/Preview.qml",{"log": log})
        }


        ProgressCircle {
            id: loadProgress
            visible: previewPageLoader.status == Loader.Loading
            width: Units.dp(64)
            height: Units.dp(64)
            anchors.centerIn: previewPageLoader
            dashThickness: Units.dp(8)
            value: previewPageLoader.progress


        }
    }


    pageStack.onPopped: {
        pageStack.pop()
        stackLoader.sourceComponent = undefined
    }


    Loader{
        id: stackLoader
        visible : false
        asynchronous: true
        onStatusChanged: if(status === Loader.Ready) itemReady()
    }

    function itemReady(){
        pageStack.push(stackLoader.item)
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


        // component for push to the stack view
        Component {
            id : fieldComponent
            TabbedPage {

                property var log : selectedLog
                id: page
                title : log.launchId

                property var _fieldObj
                property var _controlObj


                onLogChanged: {
                    var component = Qt.createComponent("modules/" + log.gameName+ "/Field.qml")
                    _fieldObj = component.createObject(fieldView,{"anchors.fill" : fieldView});


                    component = Qt.createComponent("modules/" + log.gameName+ "/Control.qml")
                    _controlObj = component.createObject(actionSheet,{"anchors.fill" : actionSheet});


                    _fieldObj.fieldLog = log
                    _controlObj.fieldObj = _fieldObj


                    actions = _controlObj.actionList
                    page.title = log.launchId

                    if(_controlObj.init) _controlObj.init()
                }


                View{
                    elevation: 1
                    anchors.fill: parent
                    anchors.margins: 14
                    id : fieldView
                }
                BottomSheet {
                    id: actionSheet

                    maxHeight: main.height/3
                    height : main.height/4 * 2

                }


            }
        }



}


