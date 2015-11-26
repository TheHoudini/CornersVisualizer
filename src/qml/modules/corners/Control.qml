import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import corners.objects 1.0
Item {
    property var fieldObj

    property bool _isStarted
    property bool _isPaused

    Connections {
        target : fieldObj
        ignoreUnknownSignals: true
        onStepFinished : {
            if(!_isStarted || _isPaused) return
            fieldObj.goToNextStep()
        }
    }


    on_IsStartedChanged: {
        if(_isStarted && !_isPaused)
        {
            fieldObj.goToNextStep()
        }else{
            fieldObj.goToStep(-1)
        }
    }

    on_IsPausedChanged: {
        if(!_isPaused && _isStarted)
            fieldObj.goToNextStep()
    }

    property list<Action> actionList : [
        Action {
            iconName: _isStarted ? "AV/stop" :"AV/play_arrow"
            name: _isStarted ? "Стоп" : "Cтарт"
            onTriggered: _isStarted = !_isStarted
        },
        Action {
            iconName: _isPaused ? "AV/replay" : "AV/pause"
            name: _isPaused ? "Возобновить" : "Пауза"
            onTriggered: _isPaused = !_isPaused
        },
        Action {
            iconName: "action/eject"
            name: "Управление"
            onTriggered: actionSheet.open()
        }

    ]

        GridLayout
        {
            anchors.fill: parent
            anchors.margins: Units.dp(14)
            columns: 2
            Label {
                id : stepLbl
                width : Units.dp(300)
                font.family: "Body2"
                font.weight: Font.Light
                text: "Текущий шаг"
                font.pixelSize: Units.dp(16)
            }

            Slider {
                id : stepSlider
                Layout.fillWidth: true
                value: 0
                tickmarksEnabled: true
                numericValueLabel: true
                stepSize: 1
                minimumValue: 0
                maximumValue: log.moves.length
                onValueChanged: fieldObj.goToStep(value-1)
                anchors.bottom: stepLbl.bottom
            }

            Label {
                id : speedlbl
                width : Units.dp(300)
                font.family: "Body2"
                font.weight: Font.Light
                text: "Скорость"
                font.pixelSize: Units.dp(16)
            }

            Slider {
                value: 1000
                Layout.fillWidth: true
                minimumValue: 500
                maximumValue: 10000
                onValueChanged: fieldObj.setAnimationDuration(value)


            }
            ListItem.Standard {
                text: "Тестовый итем"
                visible: true
                enabled: true

                onClicked: timePicker.show()
                action: Icon {
                    anchors.centerIn: parent
                    name: "Action/history"
                    size: Units.dp(32)
                }
            }
        }




    function init()
    {
        fieldObj.init()
    }
}

