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

    function getShipsMap() {
        var newArr = copyArr(basicMatrix)
        for(var i = 0 ; i< newArr.length;i++)
        {
            for(var j = 0 ; j < newArr.length;j++)
            {
                if(newArr[i][j] === 1){
                    var shipLength
                    if(newArr[i+1][j]) shipLength = -1; else shipLength = 1
                    if(shipLength > 0)
                    {

                        while(j+shipLength <= 9 && newArr[i][j+shipLength] === 1){
                            newArr[i][j+shipLength] = 0
                            shipLength++
                        }
                    }else{
                        while(i+Math.abs(shipLength) <= 9 && newArr[i+Math.abs(shipLength)][j] === 1 ){
                            newArr[i+Math.abs(shipLength)][j] = 0
                            shipLength--
                        }

                    }
                    newArr[i][j] = shipLength
                }
            }
        }
        return newArr
    }

    function syncShips(){
        printArr(basicMatrix)
        var ships1It = 0
        var ships2It = 0
        var ships3It = 0
        var ships4It = 0
        var shipsMap = getShipsMap()
        for(var i = 0 ; i < shipsMap.length; i++)
            for(var j = 0 ; j < shipsMap.length ; j++)
            {
                var target
                switch(Math.abs(shipsMap[i][j])){
                case 1 :
                    target = ships1.itemAt(ships1It)
                    ships1It++
                    break
                case 2:
                    target = ships2.itemAt(ships2It)
                    ships2It++
                    break
                case 3 :
                    target = ships3.itemAt(ships3It)
                    ships3It++
                    break
                case 4:
                    target = ships4.itemAt(ships4It)
                    ships4It++
                    break
                default :
                    continue

                }

                target.i_pos = i
                target.j_pos = j
                if(shipsMap[i][j] < 0) target.rotated = true; else target.rotated = false

            }

    }

    function copyArr(arr){

        var newArr = []
        for(var i = 0 ; i< arr.length;i++)
        {
            newArr[i] = []
            for(var j = 0 ; j < arr.length;j++)
            {
                newArr[i][j] = Number(basicMatrix[i][j])
            }
        }
        return newArr
    }

    function printArr(arr){
        for(var i = 0 ; i< fieldHeight;i++)
        {
            var str = ""
            for(var j = 0 ; j < fieldWidth;j++)
            {
                str += " " + arr[i][j]
            }
            print(str)
        }
        print()
    }

    GridLayout{
        id : mainGrid
        z : 3
        anchors.fill: parent
        columns: fieldHeight
        rows: fieldWidth
        columnSpacing: 0
        rowSpacing: 0
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

    Ink{

    }

    Repeater{
        id : ships1
        model : 4
        Icon{
            z :  mainGrid.z -1
            height: mainGrid.height/10
            width : mainGrid.width/10
            anchors.left: parent.left
            anchors.top: parent.top
            size: Math.max(parent.width,parent.height)

            source : Qt.resolvedUrl("image/ship1" +(rotated? "_v" : "")+".svg")
            color: Theme.primaryColor


            property int i_pos : 3
            property int j_pos : 3
            property bool rotated : false
            anchors.leftMargin: parent.width/10*j_pos
            anchors.topMargin : parent.height/10*i_pos
        }
    }

    Repeater{
        id : ships2
        model : 3
        Icon{
            z :  mainGrid.z -1
            height: rotated ? mainGrid.height/10*2 : mainGrid.height/10
            width : rotated? mainGrid.width/10 : mainGrid.width/10*2
            anchors.left: parent.left
            anchors.top : parent.top
            size: Math.max(parent.width,parent.height)
            source : Qt.resolvedUrl("image/ship2" +(rotated? "_v" : "")+".svg")
            color: Theme.primaryColor
            property int i_pos : 3
            property int j_pos : 3
            property bool rotated : false
            anchors.leftMargin: parent.width/10*j_pos
            anchors.topMargin : parent.height/10*i_pos
        }
    }

    Repeater{
        id : ships3
        model : 2
        Icon{
            property int i_pos : 3
            property int j_pos : 3
            property bool rotated : false

            z :  mainGrid.z -1
            height: rotated ? mainGrid.height/10*3 : mainGrid.height/10
            width : rotated? mainGrid.width/10 : mainGrid.width/10*3
            size: Math.max(parent.width,parent.height)
            source : Qt.resolvedUrl("image/ship3" +(rotated? "_v" : "")+".svg")
            color: Theme.primaryColor


            anchors.left: parent.left
            anchors.top : parent.top
            anchors.leftMargin: parent.width/10*j_pos
            anchors.topMargin : parent.height/10*i_pos
        }
    }

    Repeater{
        id : ships4
        anchors.fill: parent
        model : 1
        onItemAdded: syncShips()
        Icon{
            z :  mainGrid.z -1
            height: rotated ? mainGrid.width/10 : mainGrid.height/10
            width : rotated? mainGrid.height/10*4 : (mainGrid.width/10)*4
            size: Math.max(parent.width,parent.height)
            anchors.left: parent.left
            anchors.top : parent.top
            source : Qt.resolvedUrl("image/ship4" +(rotated? "_v" : "")+".svg")
            color: Theme.primaryColor
            property int i_pos : 3
            property int j_pos : 3
            property bool rotated : false
            anchors.leftMargin: parent.width/10*j_pos
            anchors.topMargin : parent.height/10*i_pos
        }
    }

    Repeater {
        id : verticalSpacerRepeater
        model : fieldWidth+1
        Rectangle{
            width : 1
            z :  mainGrid.z -2
            height : mainGrid.height
            color  : Theme.backgroundColor
            anchors.left: mainGrid.left
            anchors.leftMargin: (1+index)*(mainGrid.width/fieldWidth)
        }

    }

    Repeater {
        id : horizontalSpacerRepeater
        model : fieldHeight+1
        z : -1
        Rectangle{
            width : 1
            z :  mainGrid.z -2
            height : mainGrid.width
            rotation: 90
            anchors.right: mainGrid.right
            anchors.rightMargin: height/2
            anchors.top : mainGrid.top
            anchors.topMargin: -height/2+((index+1)*(mainGrid.height/fieldHeight))
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
