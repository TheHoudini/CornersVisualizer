#include "bridge.h"
#include <QFile>
#include <QDebug>

#include <QVariantMap>

// json include
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QVariant>

Bridge::Bridge(QObject *parent) : QObject(parent)
{

}

QVariantMap Bridge::getJsonFromFile(const QString &path)
{
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "wrong path";
        return QVariantMap();
    }


    QJsonDocument jsonDocument = QJsonDocument::fromJson(file.readAll());
    return jsonDocument.toVariant().toMap();
}

