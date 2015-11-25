import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
ActionButton {
    id : cornerBtn
    property variant newParent : cornerBtn
    property int animDuration : 1000
    width :  Math.min(parent.width,parent.height)*0.8
    height : width
    anchors.centerIn: parent

    signal animationFinished
    z : 3

    states: [
        State {
            name: "move"
            PropertyChanges {
                target: cornerBtn
                anchors.centerIn : undefined
            }
            ParentChange { target: cornerBtn; parent: newParent; x: (newParent.width-cornerBtn.width)/2;
                                                                 y: (newParent.height-cornerBtn.height)/2 }
        },
        State{
            name : "ready"
            ParentChange { target: cornerBtn; parent: newParent; x: 0; y: 0 }
        }

    ]


    transitions: Transition {
        from : "*"
        to : "move"
        onRunningChanged: {
            if(!running)
            {
                anchors.centerIn = newParent
                state = "ready"
                animationFinished()
            }
        }

        ParentAnimation {
            NumberAnimation { id : anim ; properties: "x,y"; duration: cornerBtn.animDuration ;easing.type:  Easing.OutQuad }
        }
    }


    function reparentTo(par)
    {
        if(cornerBtn.state == "move")
            return
        newParent = par
        state = "move"
    }

    function fastReparentTo(par)
    {
        cornerBtn.parent = par
    }

}

