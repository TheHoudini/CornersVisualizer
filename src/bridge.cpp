#include "bridge.h"
#include <QFile>
#include <QDebug>

#include <QVariantMap>

// json include
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QVariant>
#include <QFileDialog>

Bridge::Bridge(QObject *parent) : QObject(parent)
{
    m_settings = new QSettings("app.ini",QSettings::IniFormat);
}

Bridge::~Bridge()
{
    delete m_settings;
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

void Bridge::setValue(const QString &key, const QVariant &value)
{
    m_settings->setValue(key,value);
}

QVariant Bridge::getValue(const QString &key)
{
    return m_settings->value(key);
}

void Bridge::setArray(const QString &key, const QVariantList &value)
{
    m_settings->setValue(key,value);
}

QVariantList Bridge::getArray(const QString &key)
{
    return m_settings->value(key).toList();
}

void Bridge::setObject(const QString &key, const QVariantMap &value)
{
    m_settings->setValue(key,value);
}

QVariantMap Bridge::getObject(const QString &key)
{
    return m_settings->value(key).toMap();
}

QString Bridge::getFilePath()
{
    return QFileDialog::getOpenFileName();
}

