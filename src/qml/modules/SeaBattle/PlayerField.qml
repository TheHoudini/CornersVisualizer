import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

View {
    id : view
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
             Layout.minimumWidth : 1
             Layout.minimumHeight : 1
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
           // gradient: verticalGradient
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

            //gradient: horizontalGradient
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

// deprecated
/*
    Gradient {
        id : verticalGradient
        stops: getGradiantStops(fieldHeight)
    }
    Gradient {
        id: horizontalGradient
        stops : getGradiantStops(fieldWidth)
    }

    function getGradiantStops(count){
        var list = []
        for(var i = 0 ; i < count*2+1 ; i++)
        {
            var newObject = Qt.createQmlObject('import QtQuick 2.5; GradientStop { position: '+ (1.0/(count*2)*(i)) +'; color: '+
                                               i+' % 2 ? Theme.backgroundColor : "white" }',
                                                   verticalGradient, "");
            list.push(newObject)
        }

        return list
    }

*/





}
