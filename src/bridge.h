#ifndef BRIDGE_H
#define BRIDGE_H

#include <QObject>
#include <QVariantMap>

class Bridge : public QObject
{
    Q_OBJECT
public:
    explicit Bridge(QObject *parent = 0);

    // read data from file in @path , convert data to json
    // and return map with json(variant.toMap())
    Q_INVOKABLE QVariantMap getJsonFromFile(const QString &path);
signals:

public slots:
};

#endif // BRIDGE_H
