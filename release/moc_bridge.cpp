/****************************************************************************
** Meta object code from reading C++ file 'bridge.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/bridge.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'bridge.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Bridge_t {
    QByteArrayData data[13];
    char stringdata0[107];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Bridge_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Bridge_t qt_meta_stringdata_Bridge = {
    {
QT_MOC_LITERAL(0, 0, 6), // "Bridge"
QT_MOC_LITERAL(1, 7, 15), // "getJsonFromFile"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 4), // "path"
QT_MOC_LITERAL(4, 29, 8), // "setValue"
QT_MOC_LITERAL(5, 38, 3), // "key"
QT_MOC_LITERAL(6, 42, 5), // "value"
QT_MOC_LITERAL(7, 48, 8), // "getValue"
QT_MOC_LITERAL(8, 57, 8), // "setArray"
QT_MOC_LITERAL(9, 66, 8), // "getArray"
QT_MOC_LITERAL(10, 75, 9), // "setObject"
QT_MOC_LITERAL(11, 85, 9), // "getObject"
QT_MOC_LITERAL(12, 95, 11) // "getFilePath"

    },
    "Bridge\0getJsonFromFile\0\0path\0setValue\0"
    "key\0value\0getValue\0setArray\0getArray\0"
    "setObject\0getObject\0getFilePath"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Bridge[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   54,    2, 0x02 /* Public */,
       4,    2,   57,    2, 0x02 /* Public */,
       7,    1,   62,    2, 0x02 /* Public */,
       8,    2,   65,    2, 0x02 /* Public */,
       9,    1,   70,    2, 0x02 /* Public */,
      10,    2,   73,    2, 0x02 /* Public */,
      11,    1,   78,    2, 0x02 /* Public */,
      12,    0,   81,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QVariantMap, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString, QMetaType::QVariant,    5,    6,
    QMetaType::QVariant, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::QString, QMetaType::QVariantList,    5,    6,
    QMetaType::QVariantList, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::QString, QMetaType::QVariantMap,    5,    6,
    QMetaType::QVariantMap, QMetaType::QString,    5,
    QMetaType::QString,

       0        // eod
};

void Bridge::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Bridge *_t = static_cast<Bridge *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QVariantMap _r = _t->getJsonFromFile((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = _r; }  break;
        case 1: _t->setValue((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QVariant(*)>(_a[2]))); break;
        case 2: { QVariant _r = _t->getValue((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 3: _t->setArray((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QVariantList(*)>(_a[2]))); break;
        case 4: { QVariantList _r = _t->getArray((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        case 5: _t->setObject((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QVariantMap(*)>(_a[2]))); break;
        case 6: { QVariantMap _r = _t->getObject((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = _r; }  break;
        case 7: { QString _r = _t->getFilePath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject Bridge::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Bridge.data,
      qt_meta_data_Bridge,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Bridge::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Bridge::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Bridge.stringdata0))
        return static_cast<void*>(const_cast< Bridge*>(this));
    return QObject::qt_metacast(_clname);
}

int Bridge::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
