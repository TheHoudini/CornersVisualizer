import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

Item {
    property var fieldLog
    property int currentStep : -1

    property bool firstPlayerActive : true

    property int fpHits : 0
    property int spHits : 0


    function init(){
    }

    function goToNextStep()
    {
        if(currentStep >= fieldLog.moves.length-1)
            return
        currentStep++
        var activeField = firstPlayerActive ? firstField : secondField
        if( activeField.shoot(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1]) )
        {
            if(firstPlayerActive) fpHits++ ; else spHits++
        }else
            firstPlayerActive = !firstPlayerActive
    }

    function goToPrevStep(){
        if(currentStep < 0)
            return
        var activeField = firstPlayerActive ? firstField : secondField
        activeField.unshoot(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1])
        var hits = firstPlayerActive ? fpHits : spHits
        hits--
        currentStep--;
        if(hits === 0 || !activeField.check(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1]))
            firstPlayerActive = !firstPlayerActive

    }

    RowLayout{
        anchors.fill: parent
        View{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 25
            Layout.minimumWidth: 25
            elevation: 1
            PlayerField{
                id  : firstField
                anchors.fill: parent
                basicMatrix: fieldLog.player1Position
                anchors.margins: Units.dp(10)

            }
        }

        View{
            elevation: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: Units.dp(50)
            Layout.minimumWidth: Units.dp(70)
            Layout.maximumWidth: Units.dp(100)
            ColumnLayout{
                anchors.fill: parent
                ProgressCircle {
                    id: determinateProgress
                    Layout.alignment: Qt.AlignCenter
                    width: parent.width/1.4
                    height: width
                    indeterminate: false
                    minimumValue: 0
                    maximumValue: fieldLog.moves.length ? fieldLog.moves.length : 1
                    value: fieldLog.moves.length > 0 ? currentStep+1 : 1
                    Label {

                        style: "body2"
                        font.weight: Font.Light
                        font.pixelSize: Units.dp(34)
                        anchors.centerIn: parent
                        text: currentStep+1
                    }
                }

                RowLayout{
                    Layout.alignment: Qt.AlignCenter
                    Label {
                        id : leftStepsLbl
                        style: "body2"
                        font.pixelSize: Units.dp(34)
                        font.weight: Font.Light
                        text: fpHits
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.maximumHeight: leftStepsLbl.height
                        width: 1
                        color : Theme.backgroundColor
                    }

                    Label {
                        style: "body2"
                        font.weight: Font.Light
                        font.pixelSize: Units.dp(34)
                        text: spHits
                    }
                }
            }

        }

        View{
            elevation: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 25
            Layout.minimumWidth: 25
            PlayerField{
                id : secondField
                anchors.fill: parent
                anchors.margins: Units.dp(10)
                basicMatrix: fieldLog.player1Position
            }

        }


    }
}
