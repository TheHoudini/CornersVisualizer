#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QJsonArray>
#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void on_selectPathBtn_clicked();

    void on_saveLogBtn_clicked();

    void on_addStepBtn_clicked();

private:
    Ui::MainWindow *ui;
    QString m_filepath;
    QJsonArray m_moveArray;

};

#endif // MAINWINDOW_H
