#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_selectPathBtn_clicked()
{
    m_filepath = QFileDialog::getOpenFileName(this);
}

void MainWindow::on_saveLogBtn_clicked()
{
    QJsonObject logObject;
    logObject["launchId"] = ui->idEdit->text().toInt();
    QJsonArray logPlayerArray;
    logPlayerArray.append(ui->fPlayerNameEdit->text());
    logPlayerArray.append(ui->sPlayerNameEdit->text());
    logObject["players"] = logPlayerArray;
    logObject["gameDate"] = ui->dateTimeEdit->dateTime().toString();
    if(ui->rectangleRb->isChecked())
        logObject["arrangement"] = "rectangle";
    else if(ui->squareRb->isChecked())
        logObject["arrangement"] = "square";
    else
        logObject["arrangement"] = "circle";
    logObject["maxMoveCount"] = ui->maxStepCountSb->value();
    QJsonArray array;
    array.append(ui->fPlayerWinnerRb->isChecked());
    array.append(ui->sPlayerIsWinnerRb->isChecked());
    logObject["result"] = array;
    logObject["moves"] =   m_moveArray;
    QFile file(m_filepath);
    if(file.open(QIODevice::ReadWrite | QIODevice::Truncate))
    {
    QJsonDocument document(logObject);
    file.write(document.toJson());
    }

}

void MainWindow::on_addStepBtn_clicked()
{
    QJsonArray stepArray;
    stepArray.append(ui->x0Sb->value());
    stepArray.append(ui->y0Sb->value());
    stepArray.append(ui->x1Sb->value());\
    stepArray.append(ui->y1Sb->value());
    m_moveArray.append(stepArray);
}
