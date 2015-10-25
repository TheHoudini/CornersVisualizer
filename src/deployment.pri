android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target qmldir
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target qmldir
} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target qmldir
}

export(INSTALLS)

SOURCES += \
    $$PWD/main.cpp \
    $$PWD/bridge.cpp


DISTFILES += \
    $$PWD/qml/main.qml \
    $$PWD/qml/PreviewBlock.qml \
    $$PWD/qml/PreviewGeneral.qml \
    $$PWD/qml/PreviewSeparator.qml \
    $$PWD/qml/PreviewTab.qml \
    $$PWD/qml/field/CornersField.qml \
    $$PWD/qml/field/Corner.qml



RESOURCES += \
    $$PWD/resources/res.qrc

HEADERS += \
    $$PWD/bridge.h
