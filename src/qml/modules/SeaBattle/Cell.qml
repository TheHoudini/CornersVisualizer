import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

View {
    property bool isActive : false
    Rectangle{
        id : rect
        color: isActive ? Theme.primaryColor : "transparent"
        anchors.fill: parent
        Icon {
            id : icon
            visible : false
            anchors.centerIn: parent
            name : "Content/clear"
            color: Theme.accentColor
            size : Math.min(parent.width,parent.height)
        }

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
