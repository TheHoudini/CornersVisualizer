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
    ~Bridge();

    // read data from file in @path , convert data to json
    // and return map with json(variant.toMap())
    Q_INVOKABLE QVariantMap getJsonFromFile(const QString &path);

    // functions for work with regedit
    Q_INVOKABLE void setValue(const QString &key , const QVariant &value);
    Q_INVOKABLE QVariant getValue(const QString &key);

    Q_INVOKABLE void setArray(const QString &key , const QVariantList &value);
    Q_INVOKABLE QVariantList getArray(const QString &key);

    Q_INVOKABLE void setObject(const QString &key , const QVariantMap &value);
    Q_INVOKABLE QVariantMap getObject(const QString &key);


    Q_INVOKABLE QString getFilePath();
signals:

public slots:

private :
    QSettings *m_settings;

};

#endif // BRIDGE_H
