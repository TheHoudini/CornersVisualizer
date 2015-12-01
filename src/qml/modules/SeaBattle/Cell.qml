import QtQuick 2.5
import Material 0.1

Item {
    property bool isActive : false
    Rectangle{
        id : rect
        visible: isActive
        color: isActive ? Theme.primaryColor : "transparent"
        anchors.fill: parent
    }
    Icon {
        id : icon
        visible : false
        anchors.centerIn: parent
        name : "Content/clear"
        color: Theme.accentColor
        size : Math.min(parent.width,parent.height)
    }

    function shoot(){
        icon.visible = true
        return isActive
    }

    function normalize(){
        icon.visible = false
        return isActive
    }


}
