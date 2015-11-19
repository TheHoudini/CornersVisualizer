/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QDateTimeEdit>
#include <QtWidgets/QGroupBox>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QRadioButton>
#include <QtWidgets/QScrollArea>
#include <QtWidgets/QSpinBox>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QVBoxLayout *verticalLayout_9;
    QVBoxLayout *verticalLayout_4;
    QHBoxLayout *horizontalLayout;
    QLabel *label;
    QLineEdit *idEdit;
    QHBoxLayout *horizontalLayout_3;
    QLabel *label_2;
    QHBoxLayout *horizontalLayout_2;
    QVBoxLayout *verticalLayout;
    QLineEdit *fPlayerNameEdit;
    QLineEdit *sPlayerNameEdit;
    QGroupBox *groupBox;
    QVBoxLayout *verticalLayout_2;
    QRadioButton *fPlayerWinnerRb;
    QRadioButton *sPlayerIsWinnerRb;
    QDateTimeEdit *dateTimeEdit;
    QHBoxLayout *horizontalLayout_4;
    QLabel *label_3;
    QSpinBox *maxStepCountSb;
    QHBoxLayout *horizontalLayout_7;
    QLabel *label_4;
    QVBoxLayout *verticalLayout_5;
    QLabel *label_5;
    QHBoxLayout *horizontalLayout_5;
    QSpinBox *x0Sb;
    QSpinBox *y0Sb;
    QVBoxLayout *verticalLayout_6;
    QLabel *label_6;
    QHBoxLayout *horizontalLayout_6;
    QSpinBox *x1Sb;
    QSpinBox *y1Sb;
    QVBoxLayout *verticalLayout_7;
    QPushButton *addStepBtn;
    QPushButton *viewSteps;
    QScrollArea *scrollArea;
    QWidget *scrollAreaWidgetContents;
    QHBoxLayout *horizontalLayout_9;
    QVBoxLayout *verticalLayout_3;
    QRadioButton *squareRb;
    QRadioButton *rectangleRb;
    QRadioButton *circleRb;
    QVBoxLayout *verticalLayout_8;
    QLabel *label_7;
    QHBoxLayout *horizontalLayout_8;
    QPushButton *selectPathBtn;
    QPushButton *saveLogBtn;
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QStringLiteral("MainWindow"));
        MainWindow->resize(664, 421);
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        verticalLayout_9 = new QVBoxLayout(centralWidget);
        verticalLayout_9->setSpacing(6);
        verticalLayout_9->setContentsMargins(11, 11, 11, 11);
        verticalLayout_9->setObjectName(QStringLiteral("verticalLayout_9"));
        verticalLayout_4 = new QVBoxLayout();
        verticalLayout_4->setSpacing(6);
        verticalLayout_4->setObjectName(QStringLiteral("verticalLayout_4"));
        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
        horizontalLayout->setObjectName(QStringLiteral("horizontalLayout"));
        label = new QLabel(centralWidget);
        label->setObjectName(QStringLiteral("label"));

        horizontalLayout->addWidget(label);

        idEdit = new QLineEdit(centralWidget);
        idEdit->setObjectName(QStringLiteral("idEdit"));

        horizontalLayout->addWidget(idEdit);


        verticalLayout_4->addLayout(horizontalLayout);

        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setSpacing(6);
        horizontalLayout_3->setObjectName(QStringLiteral("horizontalLayout_3"));
        label_2 = new QLabel(centralWidget);
        label_2->setObjectName(QStringLiteral("label_2"));

        horizontalLayout_3->addWidget(label_2);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setObjectName(QStringLiteral("horizontalLayout_2"));
        verticalLayout = new QVBoxLayout();
        verticalLayout->setSpacing(6);
        verticalLayout->setObjectName(QStringLiteral("verticalLayout"));
        fPlayerNameEdit = new QLineEdit(centralWidget);
        fPlayerNameEdit->setObjectName(QStringLiteral("fPlayerNameEdit"));

        verticalLayout->addWidget(fPlayerNameEdit);

        sPlayerNameEdit = new QLineEdit(centralWidget);
        sPlayerNameEdit->setObjectName(QStringLiteral("sPlayerNameEdit"));

        verticalLayout->addWidget(sPlayerNameEdit);


        horizontalLayout_2->addLayout(verticalLayout);

        groupBox = new QGroupBox(centralWidget);
        groupBox->setObjectName(QStringLiteral("groupBox"));
        verticalLayout_2 = new QVBoxLayout(groupBox);
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setContentsMargins(11, 11, 11, 11);
        verticalLayout_2->setObjectName(QStringLiteral("verticalLayout_2"));
        fPlayerWinnerRb = new QRadioButton(groupBox);
        fPlayerWinnerRb->setObjectName(QStringLiteral("fPlayerWinnerRb"));
        fPlayerWinnerRb->setChecked(true);

        verticalLayout_2->addWidget(fPlayerWinnerRb);

        sPlayerIsWinnerRb = new QRadioButton(groupBox);
        sPlayerIsWinnerRb->setObjectName(QStringLiteral("sPlayerIsWinnerRb"));

        verticalLayout_2->addWidget(sPlayerIsWinnerRb);


        horizontalLayout_2->addWidget(groupBox);


        horizontalLayout_3->addLayout(horizontalLayout_2);


        verticalLayout_4->addLayout(horizontalLayout_3);

        dateTimeEdit = new QDateTimeEdit(centralWidget);
        dateTimeEdit->setObjectName(QStringLiteral("dateTimeEdit"));

        verticalLayout_4->addWidget(dateTimeEdit);

        horizontalLayout_4 = new QHBoxLayout();
        horizontalLayout_4->setSpacing(6);
        horizontalLayout_4->setObjectName(QStringLiteral("horizontalLayout_4"));
        label_3 = new QLabel(centralWidget);
        label_3->setObjectName(QStringLiteral("label_3"));

        horizontalLayout_4->addWidget(label_3);

        maxStepCountSb = new QSpinBox(centralWidget);
        maxStepCountSb->setObjectName(QStringLiteral("maxStepCountSb"));

        horizontalLayout_4->addWidget(maxStepCountSb);


        verticalLayout_4->addLayout(horizontalLayout_4);


        verticalLayout_9->addLayout(verticalLayout_4);

        horizontalLayout_7 = new QHBoxLayout();
        horizontalLayout_7->setSpacing(6);
        horizontalLayout_7->setObjectName(QStringLiteral("horizontalLayout_7"));
        label_4 = new QLabel(centralWidget);
        label_4->setObjectName(QStringLiteral("label_4"));

        horizontalLayout_7->addWidget(label_4);

        verticalLayout_5 = new QVBoxLayout();
        verticalLayout_5->setSpacing(6);
        verticalLayout_5->setObjectName(QStringLiteral("verticalLayout_5"));
        label_5 = new QLabel(centralWidget);
        label_5->setObjectName(QStringLiteral("label_5"));

        verticalLayout_5->addWidget(label_5);

        horizontalLayout_5 = new QHBoxLayout();
        horizontalLayout_5->setSpacing(6);
        horizontalLayout_5->setObjectName(QStringLiteral("horizontalLayout_5"));
        x0Sb = new QSpinBox(centralWidget);
        x0Sb->setObjectName(QStringLiteral("x0Sb"));

        horizontalLayout_5->addWidget(x0Sb);

        y0Sb = new QSpinBox(centralWidget);
        y0Sb->setObjectName(QStringLiteral("y0Sb"));

        horizontalLayout_5->addWidget(y0Sb);


        verticalLayout_5->addLayout(horizontalLayout_5);


        horizontalLayout_7->addLayout(verticalLayout_5);

        verticalLayout_6 = new QVBoxLayout();
        verticalLayout_6->setSpacing(6);
        verticalLayout_6->setObjectName(QStringLiteral("verticalLayout_6"));
        label_6 = new QLabel(centralWidget);
        label_6->setObjectName(QStringLiteral("label_6"));

        verticalLayout_6->addWidget(label_6);

        horizontalLayout_6 = new QHBoxLayout();
        horizontalLayout_6->setSpacing(6);
        horizontalLayout_6->setObjectName(QStringLiteral("horizontalLayout_6"));
        x1Sb = new QSpinBox(centralWidget);
        x1Sb->setObjectName(QStringLiteral("x1Sb"));

        horizontalLayout_6->addWidget(x1Sb);

        y1Sb = new QSpinBox(centralWidget);
        y1Sb->setObjectName(QStringLiteral("y1Sb"));

        horizontalLayout_6->addWidget(y1Sb);


        verticalLayout_6->addLayout(horizontalLayout_6);


        horizontalLayout_7->addLayout(verticalLayout_6);

        verticalLayout_7 = new QVBoxLayout();
        verticalLayout_7->setSpacing(6);
        verticalLayout_7->setObjectName(QStringLiteral("verticalLayout_7"));
        addStepBtn = new QPushButton(centralWidget);
        addStepBtn->setObjectName(QStringLiteral("addStepBtn"));

        verticalLayout_7->addWidget(addStepBtn);

        viewSteps = new QPushButton(centralWidget);
        viewSteps->setObjectName(QStringLiteral("viewSteps"));

        verticalLayout_7->addWidget(viewSteps);


        horizontalLayout_7->addLayout(verticalLayout_7);


        verticalLayout_9->addLayout(horizontalLayout_7);

        scrollArea = new QScrollArea(centralWidget);
        scrollArea->setObjectName(QStringLiteral("scrollArea"));
        scrollArea->setWidgetResizable(true);
        scrollAreaWidgetContents = new QWidget();
        scrollAreaWidgetContents->setObjectName(QStringLiteral("scrollAreaWidgetContents"));
        scrollAreaWidgetContents->setGeometry(QRect(0, 0, 644, 88));
        horizontalLayout_9 = new QHBoxLayout(scrollAreaWidgetContents);
        horizontalLayout_9->setSpacing(6);
        horizontalLayout_9->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_9->setObjectName(QStringLiteral("horizontalLayout_9"));
        verticalLayout_3 = new QVBoxLayout();
        verticalLayout_3->setSpacing(6);
        verticalLayout_3->setObjectName(QStringLiteral("verticalLayout_3"));
        squareRb = new QRadioButton(scrollAreaWidgetContents);
        squareRb->setObjectName(QStringLiteral("squareRb"));
        squareRb->setChecked(true);

        verticalLayout_3->addWidget(squareRb);

        rectangleRb = new QRadioButton(scrollAreaWidgetContents);
        rectangleRb->setObjectName(QStringLiteral("rectangleRb"));

        verticalLayout_3->addWidget(rectangleRb);

        circleRb = new QRadioButton(scrollAreaWidgetContents);
        circleRb->setObjectName(QStringLiteral("circleRb"));

        verticalLayout_3->addWidget(circleRb);


        horizontalLayout_9->addLayout(verticalLayout_3);

        scrollArea->setWidget(scrollAreaWidgetContents);

        verticalLayout_9->addWidget(scrollArea);

        verticalLayout_8 = new QVBoxLayout();
        verticalLayout_8->setSpacing(6);
        verticalLayout_8->setObjectName(QStringLiteral("verticalLayout_8"));
        label_7 = new QLabel(centralWidget);
        label_7->setObjectName(QStringLiteral("label_7"));

        verticalLayout_8->addWidget(label_7);

        horizontalLayout_8 = new QHBoxLayout();
        horizontalLayout_8->setSpacing(6);
        horizontalLayout_8->setObjectName(QStringLiteral("horizontalLayout_8"));
        selectPathBtn = new QPushButton(centralWidget);
        selectPathBtn->setObjectName(QStringLiteral("selectPathBtn"));

        horizontalLayout_8->addWidget(selectPathBtn);

        saveLogBtn = new QPushButton(centralWidget);
        saveLogBtn->setObjectName(QStringLiteral("saveLogBtn"));

        horizontalLayout_8->addWidget(saveLogBtn);


        verticalLayout_8->addLayout(horizontalLayout_8);


        verticalLayout_9->addLayout(verticalLayout_8);

        MainWindow->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(MainWindow);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 664, 21));
        MainWindow->setMenuBar(menuBar);
        mainToolBar = new QToolBar(MainWindow);
        mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
        MainWindow->addToolBar(Qt::TopToolBarArea, mainToolBar);
        statusBar = new QStatusBar(MainWindow);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        MainWindow->setStatusBar(statusBar);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "JsonGenerator", 0));
        label->setText(QApplication::translate("MainWindow", "Id \320\270\320\263\321\200\321\213", 0));
        label_2->setText(QApplication::translate("MainWindow", "\320\230\320\274\320\265\320\275\320\260 \320\270\320\263\321\200\320\276\320\272\320\276\320\262", 0));
        groupBox->setTitle(QString());
        fPlayerWinnerRb->setText(QString());
        sPlayerIsWinnerRb->setText(QString());
        label_3->setText(QApplication::translate("MainWindow", "\320\234\320\260\320\272\321\201\320\270\320\274\320\260\320\273\321\214\320\275\320\276\320\265 \320\272\320\276\320\273-\320\262\320\276 \321\205\320\276\320\264\320\276\320\262", 0));
        label_4->setText(QApplication::translate("MainWindow", "\320\234\320\265\320\275\320\265\320\264\320\266\320\265\321\200 \321\205\320\276\320\264\320\276\320\262", 0));
        label_5->setText(QApplication::translate("MainWindow", "\320\235\320\260\321\207\320\260\320\273\321\214\320\275\320\260\321\217 \321\202\320\276\321\207\320\272\320\260", 0));
        label_6->setText(QApplication::translate("MainWindow", "\320\232\320\276\320\275\320\265\321\207\320\275\320\260\321\217 \321\202\320\276\321\207\320\272\320\260", 0));
        addStepBtn->setText(QApplication::translate("MainWindow", "\320\224\320\276\320\261\320\260\320\262\320\270\321\202\321\214 \321\210\320\260\320\263", 0));
        viewSteps->setText(QApplication::translate("MainWindow", "\320\237\321\200\320\276\321\201\320\274\320\276\321\202\321\200 \321\210\320\260\320\263\320\276\320\262", 0));
        squareRb->setText(QApplication::translate("MainWindow", "Square", 0));
        rectangleRb->setText(QApplication::translate("MainWindow", "Rectangle", 0));
        circleRb->setText(QApplication::translate("MainWindow", "Circle", 0));
        label_7->setText(QApplication::translate("MainWindow", "\320\241\320\276\321\205\321\200\320\260\320\275\320\265\320\275\320\270\320\265 \320\273\320\276\320\263\320\260 : unknown path", 0));
        selectPathBtn->setText(QApplication::translate("MainWindow", "\320\222\321\213\320\261\321\200\320\260\321\202\321\214 \320\277\321\203\321\202\321\214", 0));
        saveLogBtn->setText(QApplication::translate("MainWindow", "\320\241\320\276\321\205\321\200\320\260\320\275\320\270\321\202\321\214", 0));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
