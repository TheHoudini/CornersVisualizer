#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "bridge.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Bridge>("corners.objects",1,0,"Bridge");
    engine.load(QUrl("src/qml/main.qml"));
    engine.setOutputWarningsToStandardError(false);



    return app.exec();
}
