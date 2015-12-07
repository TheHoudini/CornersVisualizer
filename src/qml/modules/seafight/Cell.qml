import QtQuick 2.5
import Material 0.1

Item {
    property bool isActive : false

    Icon {
        id : icon
        visible : false
        anchors.centerIn: parent
        source:  !isActive ?  Qt.resolvedUrl("image/bomb.svg") : Qt.resolvedUrl("image/hit.svg")
        color: Theme.accentColor
        size : Math.min(parent.width,parent.height)
    }

    Ink{
        id : ink
        visible : false
        focusColor: Theme.accentColor
        anchors.fill: parent
    }

    function shoot(){
        ink.visible = true
        ink.createTapCircle(ink.x+ink.height/2,ink.y+ink.width/2)
        icon.visible = true
        ink.cancel()
        return isActive
    }

    function normalize(){
        icon.visible = false
        return isActive
    }



}
