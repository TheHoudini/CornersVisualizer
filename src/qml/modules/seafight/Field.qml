import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.1

Item {
    property var fieldLog
    property int currentStep : -1

    property bool firstPlayerActive : true
    property int fpHits : 0
    property int spHits : 0


    function getStepArr()
    {
        var arr = []
        firstPlayerActive = true
        for(var i = 0 ; i <= fieldLog.moves.length-1 ; i++)
        {

            arr[i] = firstPlayerActive
            var activeField = firstPlayerActive ? firstField : secondField
            if(!activeField.check(fieldLog.moves[i][0],fieldLog.moves[i][1])){
                firstPlayerActive = !firstPlayerActive
            }
        }
        firstPlayerActive = true
        return arr;
    }

    function goToNextStep()
    {
        if(currentStep >= fieldLog.moves.length-1)
            return


        if(currentStep !== -1)
        {
            firstPlayerActive = getStepArr()[currentStep]
            var activeField = firstPlayerActive ? firstField : secondField
            if(!activeField.check(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1]))
                firstPlayerActive = !firstPlayerActive
        }

        activeField = firstPlayerActive ? firstField : secondField


        currentStep++
        if(firstPlayerActive) fpHits++ ; else spHits++
        activeField.shoot(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1])


    }

    function goToPrevStep(){
        if(currentStep < 0)
            return
        firstPlayerActive = getStepArr()[currentStep]


        if(firstPlayerActive) fpHits-- ; else spHits--
        var activeField = firstPlayerActive ? firstField : secondField
        activeField.unshoot(fieldLog.moves[currentStep][0],fieldLog.moves[currentStep][1])
        var hits = firstPlayerActive ? fpHits : spHits
        currentStep--;

    }



    function goToStep(step){

        print(currentStep , step)
        if(step< currentStep)
        {
            print("here")
            while(currentStep !== step )
                goToPrevStep()
        }else if(step > currentStep){
            while(currentStep !== step )
                goToNextStep()
        }

    }

    RowLayout{
        anchors.fill: parent
        //spacing: Units.dp(30)
        PlayerField{
            id  : firstField
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: width
            Layout.minimumWidth: 25
            basicMatrix: fieldLog.player1Position

        }


        View{
            elevation: 1
            id : midView
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

        PlayerField{
            id : secondField
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 25
            Layout.minimumWidth: 25
            basicMatrix: fieldLog.player1Position
        }




    }
}
