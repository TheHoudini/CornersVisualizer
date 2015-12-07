import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem


Item {

    property var log

    function open(x,y)
    {
        waveAnim.open(x,y)
    }


    signal visualizeTriggered()
    signal editTriggered()

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.topMargin: height > Units.dp(800) ? (height - Units.dp(800))/2 : 0
        contentHeight: Units.dp(800)


        clip: true




        Scrollbar {
            flickableItem: flickable
        }

        View {
            elevation: 0

            id : previewBlock

            Wave{
                id : waveAnim
                onFinished: {

                    previewBlock.elevation = 1
                    previewColumn.visible = true
                }
            }

            width : parent.width > Units.dp(800) ? Units.dp(800) : parent.width
            height: Units.dp(800)


            anchors.top : parent.top
            anchors.bottom: parent.bottom
            anchors.centerIn: parent






            anchors.margins: 14
            Column {
                id : previewColumn
                visible : false
                anchors.margins: 14
                anchors.fill: parent
                RowLayout {
                    id : previewTitleRowLayout
                    anchors.right:  parent.right
                    anchors.left: parent.left
                    height: Units.dp(180)
                    Item {
                        id : previewIcon
                        height :  parent.height/2
                        width : height
                        Icon {
                            id : previewIconLoader
                            // Explicitly set the size of the
                            // Loader to the parent item's size
                            size : Math.min(parent.width,parent.height)
                            color:  Theme.primaryColor
                            source:  Qt.resolvedUrl("image/logo.svg")
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


                                text: log.gameDate
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
                    id : previewRowLayout
                    anchors.top : previewPreviewTitle.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: parent.width/3.6


                    anchors.topMargin: 8

                    Loader{
                        id : previewFLoader
                        active : false
                        visible : status === Loader.Ready
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 20
                        Layout.minimumHeight: width/3
                        asynchronous: true
                        onLoaded: {
                            item.fieldLog = log
                        }
                        source : "Field.qml"



                    }
                    ActionButton{
                        visible : !previewFLoader.active
                        anchors.centerIn: previewRowLayout
                        iconName: "AV/replay"
                        backgroundColor: Theme.primaryColor
                        onClicked: previewFLoader.active = true
                    }

                    ProgressCircle {
                        id: loadProgress
                        visible: previewFLoader.status == Loader.Loading
                        width: Units.dp(64)
                        height: Units.dp(64)
                        anchors.centerIn: previewRowLayout
                        dashThickness: Units.dp(8)
                    }

                }




            }






        }
    }

    Scrollbar {
        flickableItem: flickable
    }
}
