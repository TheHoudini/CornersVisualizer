#ifndef BRIDGE_H
#define BRIDGE_H

#include <QObject>
#include <QVariantMap>
#include <QSettings>

class Bridge : public QObject
{
    Q_OBJECT
public:
    explicit Bridge(QObject *parent = 0);

    // read data from file in @path , convert data to json
    // and return map with json(variant.toMap())
    Q_INVOKABLE QVariantMap getJsonFromFile(const QString &path);
    Q_INVOKABLE void setSetting(const QString &key , const QVariant &value);
    Q_INVOKABLE QVariant getSetting(const QString &key);
signals:

public slots:

private :
    QSettings m_settings;

};

#endif // BRIDGE_H
