import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

View {

    elevation: 1
    property int fieldWidth : 8
    property int fieldHeight : 8

    property var fieldLog

    property string fieldType : fieldLog.arrangement
    property string ftSquare : "square"
    property string ftRectangle : "rectangle"
    property string ftTriangle : "triangle"


    property int baseStep : -1

    property var houseData : ({})
    property var steps : fieldLog.moves
    property var fieldData : []
    property int currentStep : -1

    signal stepFinished()

    Component.onCompleted: {
        loadBasicGrid()
        loadCornersInStandardLocation()
        if(baseStep > -1)
            goToStep(baseStep)
    }



    GridLayout{
        id : mainGrid
        z : 2
        anchors.fill: parent
        columns: fieldHeight
        rows: fieldWidth
        columnSpacing: 0
        rowSpacing: 0

    }
   Repeater {
        id : verticalSpacerRepeater
        z : -1
        model : fieldWidth-1
        Rectangle{
            width : 2
            height : mainGrid.height
            color  : Theme.backgroundColor
            anchors.left: mainGrid.left
            anchors.leftMargin: (1+index)*(mainGrid.width/fieldWidth)
           // gradient: verticalGradient
        }

    }

    Repeater {
        id : horizontalSpacerRepeater
        model : fieldHeight-1
        Rectangle{
            width : 2
            height : mainGrid.width
            rotation: 90
            anchors.right: mainGrid.right
            anchors.rightMargin: height/2
            anchors.top : mainGrid.top
            anchors.topMargin: -height/2+((index+1)*(mainGrid.height/fieldHeight))
            color  : Theme.backgroundColor

            //gradient: horizontalGradient
        }

    }

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


    function loadBasicGrid(){
        if(mainGrid.children.length > 0)
        {
            for(var i = 0; i < mainGrid.children.length ; i++)
            {
                mainGrid.children[i].children[0].destroy()
                mainGrid.children[i].destroy()
            }
        }

        for(var i = 0 ; i < fieldWidth ; i++)
        {
            fieldData[i] = []
            for(var j  = 0 ; j < fieldHeight ; j++)
            {
                var newObject = Qt.createQmlObject('import QtQuick 2.5; import QtQuick.Layouts 1.1;
                                                        Item {
                                Layout.fillWidth : true ; Layout.fillHeight : true ; Layout.minimumWidth: 1 ; Layout.minimumHeight: 1}',
                                                   mainGrid);
                fieldData[i][j] = 0

            }
        }
    }

    function loadBasicHouseData(){
        if(fieldType == ftRectangle)
        {
            houseData.topHouse ={'left' :{'x' : 0 , 'y' : 0} }
            houseData.topHouse.right = {'x' : 3 , 'y' : 2}
            houseData.bottomHouse ={'left' : {'x' : 4 , 'y' : 5} }
            houseData.bottomHouse.right = {'x' : 7 , 'y' : 7}
        }else if(fieldType == ftSquare){
            houseData.topHouse ={'left' : {'x' : 0 , 'y' : 0} }
            houseData.topHouse.right = {'x' : 2 , 'y' : 2}
            houseData.bottomHouse ={'left' : {'x' : 5 , 'y' : 5}}
            houseData.bottomHouse.right = {'x' : 7 , 'y' : 7}
        }else if(fieldType == ftTriangle){
            houseData.isTriangle = true
            houseData.topHouse={'left' : {'x' : 0 , 'y' : 3}}
            houseData.topHouse.right = {'x' : 3 , 'y' : 0}
            houseData.bottomHouse={'left' : {'x' : 7 , 'y' : 4}}
            houseData.bottomHouse.right = {'x' : 4 , 'y' : 7}

        }
    }

    function loadCornersInStandardLocation()
    {
        loadBasicHouseData()
        // remove old figures
        for(var i = 0; i < fieldWidth ; i++)
            for(var j = 0 ; j < fieldHeight ; j++)
                if(mainGrid.children[i*fieldWidth + j].children[0])
                    mainGrid.children[i*fieldWidth + j].children[0].destroy()


        for(i = 0 ; i < fieldWidth; i ++)
        {
            for(j = 0 ; j < fieldHeight ; j++)
            {
                var cornerComponent =  Qt.createComponent("Corner.qml");

                if( (j<= houseData.topHouse.right.x && i <= houseData.topHouse.right.y)
                        || ( houseData.isTriangle && j <= houseData.topHouse.right.x
                            && i <= houseData.topHouse.left.y && i+j <= 3))
                {
                    var newObject = cornerComponent.createObject(mainGrid.children[i*fieldWidth+j])
                    newObject.backgroundColor = Theme.primaryColor
                    newObject.animationFinished.connect(stepFinished)
                    fieldData[i][j] = 1


                }else if( (i>= houseData.bottomHouse.left.y && j >= houseData.bottomHouse.left.x)
                         || ( houseData.isTriangle && j >= houseData.bottomHouse.left.y
                             && i >= houseData.bottomHouse.right.x && (i+j) >= 11 ))
                 {
                    newObject = cornerComponent.createObject(mainGrid.children[i*fieldWidth+j])
                    newObject.animationFinished.connect(stepFinished)
                    fieldData[i][j] = 2
                 }


            }
        }
    }

    function setAnimationDuration(ms)
    {
        for(var i = 0 ; i < mainGrid.children.length ; i++)
        {

            if(mainGrid.children[i].children[0]) mainGrid.children[i].children[0].animDuration = ms
        }
    }

    function makeMove(x0,y0,x1,y1)
    {
        var cornerTarget = xyItem(x0,y0).children[0]
        var cornerParent = xyItem(x1,y1)



        cornerTarget.reparentTo(cornerParent)
        imposeMoveToField(x0,y0,x1,y1)

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
    }

    function goToNextStep(){
        if(currentStep === steps.length-1)
            return

        currentStep++
        var step = steps[currentStep]
        makeMove(step[0],step[1],step[2],step[3])
    }

    function goToPrevStep(){
        if(currentStep <0)
            return
        var step = steps[currentStep]
        makeMove(step[2],step[3],step[0],step[1])
        currentStep--
    }



    function goToStep(step){
        if(step === currentStep)
            return

        var fPlayerCorners = []
        var sPlayerCorners = []


        for(var i = 0 ; i< fieldHeight;i++)
            for(var j = 0 ; j < fieldWidth;j++)
            {
                if(fieldData[i][j] === 1)
                    fPlayerCorners.push(mainGrid.children[i*fieldWidth+j].children[0])
                else if(fieldData[i][j] === 2)
                    sPlayerCorners.push(mainGrid.children[i*fieldWidth+j].children[0])
            }



        var sign = step < currentStep ? -1 : 1
        while(currentStep !== step )
        {
            currentStep += sign
            var st = steps[currentStep+(sign < 0 ? 1 : 0) ]
            imposeMoveToField(st[0],st[1],st[2],st[3])
        }


        for(i = 0 ; i< fieldHeight;i++)
            for(j = 0 ; j < fieldWidth;j++)
            {
                if(fieldData[i][j] === 1)
                {
                    fPlayerCorners.pop().fastReparentTo(mainGrid.children[i*fieldWidth+j])
                }
                else if(fieldData[i][j] === 2)
                {
                    sPlayerCorners.pop().fastReparentTo(mainGrid.children[i*fieldWidth+j])
                }
            }
    }


    function init(){
        loadCornersInStandardLocation()
    }


    // utils function

    function imposeMoveToField(x0,y0,x1,y1){
        var tmp = fieldData[gy(y1)][gx(x1)]
        fieldData[gy(y1)][gx(x1)] = fieldData[gy(y0)][gx(x0)]
        fieldData[gy(y0)][gx(x0)] = tmp
    }


    function xyItem(x,y){
        return mainGrid.children[(fieldHeight-y-1)*fieldWidth + x]
    }

    function swap(a,b)
    {
        b = [a, a = b][0];
    }

    function gx(i){
        return i
    }

    function gy(j){
        return fieldHeight - j - 1
    }

}
