#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "bridge.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Bridge>("corners.objects",1,0,"Bridge");
    engine.load(QUrl("qrc:/qml/main.qml"));



    return app.exec();
}
