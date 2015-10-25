import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import "field"
import corners.objects 1.0

ApplicationWindow {
    id: main



    property bool isDesktop : Qt.platform.os == "linux" || Qt.platform.os == "osx" || Qt.platform.os == "windows"

    width: !isDesktop ? Screen.desktopAvailableWidth : Units.dp(800)
    height: !isDesktop ? Screen.desktopAvailableHeight : Units.dp(600)


    property var logs : []
    property var selectedLog : 0

    title: "Визуализатор уголков"

    // Necessary when loading the window from C++
    visible: true


    //object with bridged data(c++)
    Bridge {
        id : bridge
    }

    Component.onCompleted: {
        var log = bridge.getJsonFromFile(":/test.json")
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

        actions: [

            Action {
                iconName: "image/color_lens"
                name: "Выбрать цвета"
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
                            onClicked: selectedLog = logs[index]
                        }
                    }
                }
            }
        }



        Loader {
            anchors.fill: parent
            asynchronous: true
            sourceComponent: tabDelegate
            onLoaded: {
                item.logsData = selectedLog.log
            }

            visible: true
        }



    }

    Component {
            id: tabDelegate
            Item {
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
                                onClicked: selectedLog = logs[index]
                            }
                        }
                    }
                }


                Flickable {
                    id: flickable
                    anchors {
                        left: sidebar.right
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                        margins: 14
                    }

                    clip: true
                    contentHeight: {
                        print(previewPage.height)
                        return Math.max(previewPage.height+30)
                    }


                    PreviewTab {
                        id : previewPage
                        visible : selectedLog && ready
                        anchors.centerIn: parent
                        log: selectedLog

                        onVisualizeTriggered: {
                            var field = fieldComponent.createObject()
                            field.log = selectedLog
                            pageStack.push({item: field, destroyOnPop:true })
                        }

                        width : parent.width > Units.dp(700) ? Units.dp(700) : parent.width - 20
                    }

                }

                ProgressCircle {
                    id: loadProgress
                    visible: !previewPage.ready
                    width: Units.dp(64)
                    height: Units.dp(64)
                    anchors.centerIn: flickable
                    dashThickness: Units.dp(8)
                    value: previewPage.progress


                }
                Scrollbar {
                    flickableItem: flickable
                }
            }
        }  // end tab delegate


        // component for push to the stack view
        Component {
            id : fieldComponent
            TabbedPage {

                property variant log : ({})
                id: page
                title : log.launchId

                onLogChanged: {
                    page.title = log.launchId
                    cornerField.fieldType = log.arrangement
                    cornerField.steps = log.moves
                    cornerField.loadCornersInStandardLocation()
                }


                View{
                    elevation: 1
                    anchors.fill: parent
                    anchors.margins: 14
                    CornersField{
                        id : cornerField
                        anchors.fill: parent
                        anchors.margins: 14
                    }
                }



            }
        }





}


