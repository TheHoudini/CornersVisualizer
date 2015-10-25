import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import "field"

import QtGraphicalEffects 1.0

View {
    elevation: 1

    id : previewBlock

    height : Units.dp(700)

    property var log


    Item{
        anchors.fill: parent
    }



    property var _overlayStep


    signal visualizeTriggered()
    signal editTriggered()


    property bool ready :  previewIconLoader.status == Loader.Ready &&
                              previewFLoader.status    == Loader.Ready &&
                              previewSLoader.status    == Loader.Ready &&
                              previewTLoader.status    == Loader.Ready &&
                              overlayLoader.status     == Loader.Ready

    property int progress : 0
    onProgressChanged: print(progress)
    property int onePercent : 20


    anchors.top : parent.top
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter



    onLogChanged: {
        updateAllFields()
    }

    function updateField(field)
    {
        field.fieldType = log.arrangement
        field.steps = log.moves
        field.reloadField()
    }


    function updateAllFields(){
        progress = 0
        previewIconLoader.setSource("field/CornersField.qml",{"fieldType" : log.arrangement ,"steps" : log.moves  })
        previewFLoader.setSource("field/CornersField.qml",{"fieldType" : log.arrangement ,"steps" : log.moves , "baseStep" : 0 })
        previewSLoader.setSource("field/CornersField.qml",{"fieldType" : log.arrangement ,"steps" : log.moves , "baseStep" : 1 })
        previewTLoader.setSource("field/CornersField.qml",{"fieldType" : log.arrangement ,"steps" : log.moves , "baseStep" : 2 })
        overlayLoader.setSource("field/CornersField.qml",{"fieldType" : log.arrangement ,"steps" : log.moves })


    }


    anchors.margins: 14
    width : parent.width > Units.dp(700) ? Units.dp(700) : parent.width - 20
    Column {
        id : previewColumn
        anchors.margins: 14
        anchors.fill: parent
        height: previewTitleRowLayout.height

        RowLayout {
            id : previewTitleRowLayout
            anchors.right:  parent.right
            anchors.left: parent.left
            height: Units.dp(180)
            Item {
                id : previewIcon
                height :  parent.height/2
                width : height
                Loader {
                    id : previewIconLoader
                    // Explicitly set the size of the
                    // Loader to the parent item's size
                    anchors.fill: parent
                    asynchronous: false
                    onLoaded: previewBlock.progress += onePercent
                }



            }

            ColumnLayout {
                anchors.verticalCenter : previewIcon.verticalCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 10
                spacing: 4

                Label {
                    id: previewNameLbl

                    Layout.alignment: Qt.AlignLeft

                    style: "title"
                    text: log.launchId
                }
                Row{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: Units.dp(5)
                    Icon {
                        id : previewDateIcon
                        name : "action/query_builder"
                        size : Units.dp(20)
                    }

                    Label {

                        id: previewDateLbl
                        Layout.fillHeight: true


                        Layout.alignment: Qt.AlignLeft

                        style: "body2"
                        font.weight: Font.Light


                        text: previewBlock.date
                    }
                }
                Flow {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: Units.dp(5)

                    Row{
                        spacing: 5
                        Item {
                            anchors.verticalCenter: previewFirstName.verticalCenter
                            anchors.topMargin: 4
                            width : Units.dp(20)
                            height: Units.dp(20)
                            Corner{
                                backgroundColor: Theme.primaryColor
                            }
                        }

                        Label{
                            id : previewFirstName
                            text : log.players[0]
                            style : "subheading"
                        }

                    }
                    Row{
                        spacing: 5
                        Rectangle {
                            anchors.verticalCenter: previewSecondName.verticalCenter
                            anchors.topMargin: 4
                            width : Units.dp(20)
                            height: Units.dp(20)
                            Corner{
                                backgroundColor: Theme.accentColor
                            }
                        }

                        Label{
                            id : previewSecondName
                            text : log.players[1]
                            style : "subheading"
                        }

                    }


                }

                Flow {
                    Layout.margins: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: Units.dp(5)

                    Button {
                                text: "Визуализировать"
                                elevation: 1
                                onClicked: visualizeTriggered()
                            }
                    Button {
                                text: "Редактировать"
                                onClicked: editTriggered()
                            }

                }




            }
        } // title bar


        Rectangle {
            id : previewFirstSeparator
            anchors.top: previewTitleRowLayout.bottom
            anchors.topMargin: Units.dp(40)
            color : Theme.backgroundColor
            width : parent.width
            height : 1
        }


        Label{
            id : previewGeneralTitle
            anchors.top : previewFirstSeparator.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 5
            style : "title"
            text: "Общая информация"


        }

        Row {
            id : previewGeneralInfoLayout
            height : previewLastGeneralLbl.height*6
            anchors.top : previewGeneralTitle.bottom
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.left: parent.left

            Column {
                anchors.leftMargin: 72
                Label {
                    style: "body1"
                    text : "Номер игры :" + log.launchId
                }

                Label {
                    style: "body1"
                    text : "Победитель : " + (log.result[0] ? log.players[0] : log.players[1])
                }
                Label {
                    style: "body1"
                    text : "Ходов :" + log.moves.length
                }
                Label {
                    style: "body1"
                    text : "Кол-во ходов за которое необходимо покинуть базу :" + log.maxMoveCount
                }
                Label {
                    id : previewLastGeneralLbl
                    style: "body1"
                    text : "Тип базового поля :" + log.arrangement
                }


            }
        }

        Rectangle {
            id : previewSecondSeparator
            anchors.top : previewGeneralInfoLayout.bottom
            color : Theme.backgroundColor
            width : parent.width
            height : 1
        }


        Label{
            id : previewPreviewTitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top : previewSecondSeparator.bottom
            anchors.topMargin: 0
            style : "title"
            text: "Предпросмотр"


        }

        RowLayout {
            anchors.top : previewPreviewTitle.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: parent.width/3.6


            anchors.topMargin: 8
            Loader{
                id : previewFLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 20
                Layout.maximumWidth: parent.height
                Layout.minimumWidth: 20
                asynchronous: true
                onLoaded: previewBlock.progress += onePercent
                MouseArea {
                    anchors.fill: parent
                    onClicked : {
                        _overlayStep = 0
                        previewOverlay.open(previewFLoader)
                    }
                }

            }
            Loader{
                id: previewSLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 20
                Layout.maximumWidth: parent.height
                Layout.minimumWidth: 20
                asynchronous: true
                onLoaded: previewBlock.progress += onePercent
                MouseArea {
                    anchors.fill: parent
                    onClicked : {
                        _overlayStep = 1
                        previewOverlay.open(previewSLoader)
                    }
                }
            }
            Loader{
                id : previewTLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 20
                Layout.maximumWidth: parent.height
                Layout.minimumWidth: 20
                asynchronous: true
                onLoaded: previewBlock.progress += onePercent
                MouseArea {
                    anchors.fill: parent
                    onClicked : {
                        _overlayStep = 2
                        previewOverlay.open(previewTLoader)
                    }
                }
            }

        }




    }


    // overlay for preview fields

    OverlayView{
        id : previewOverlay
        height : main.height/6*4
        width : main.width/6*4
        onOpened: {
            overlayLoader.item.goToStep(_overlayStep)
        }

        Loader{
            id : overlayLoader
            anchors.fill: parent
            onLoaded: previewBlock.progress += onePercent
        }


    }



}
