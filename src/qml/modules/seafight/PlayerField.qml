import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.1

View {
    id : view
    elevation: 1
    property int fieldWidth : 10
    property int fieldHeight : 10


    property var basicMatrix : [
        [1, 0, 1, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 0, 1, 1, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
    ]



    property var steps : fieldLog.moves
    property int currentStep : -1


    GridLayout{
        id : mainGrid
        z : 2
        anchors.fill: parent
        columns: fieldHeight
        rows: fieldWidth
        columnSpacing: -1
        rowSpacing: -1

        Repeater{
            model : 100
            Cell{
             Layout.fillWidth : true
             Layout.fillHeight : true
             Layout.minimumWidth : parent.width/10
             Layout.minimumHeight : parent.height/10
             Layout.maximumWidth: parent.width / 10
             Layout.maximumHeight: parent.height / 10
             isActive : basicMatrix[Math.floor(index/10)][index % 10]

            }
        }

    }
   Repeater {
        id : verticalSpacerRepeater
        z : -1
        model : fieldWidth+1
        Rectangle{
            width : 1
            height : mainGrid.height
            color  : Theme.backgroundColor
            anchors.left: mainGrid.left
            anchors.leftMargin: (1+index)*(mainGrid.width/fieldWidth)+1
        }

    }

    Repeater {
        id : horizontalSpacerRepeater
        model : fieldHeight+1
        z : -1
        Rectangle{
            width : 1
            height : mainGrid.width
            rotation: 90
            anchors.right: mainGrid.right
            anchors.rightMargin: height/2
            anchors.top : mainGrid.top
            anchors.topMargin: -height/2+((index+1)*(mainGrid.height/fieldHeight))+1
            color  : Theme.backgroundColor

        }

    }



    function shoot(y,x)
    {
        var target = mainGrid.children[y*fieldWidth+x]
        return target.shoot()
    }

    function unshoot(y,x)
    {

        var target = mainGrid.children[y*fieldWidth+x]
        return target.normalize()
    }

    function check(y,x)
    {
        var target = mainGrid.children[y*fieldWidth+x]
        return target.isActive
    }

    function init(){
        generateField()
    }







}
