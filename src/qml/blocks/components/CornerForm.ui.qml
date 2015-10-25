import QtQuick 2.4

Item {

    property alias image: cornerImage

    width: 50
    height: 50

    Image {
        id: cornerImage
        anchors.fill: parent
        source: "qrc:/qtquickplugin/images/template_image.png"
    }
}

