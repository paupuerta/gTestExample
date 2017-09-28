#ifndef TST_TCPCOMMSOCKET_H
#define TST_TCPCOMMSOCKET_H

#include <QtCore/QString>
#include <QtTest/QtTest>

#include <iostream>

#include <QTcpSocket>
#include <QTcpServer>

class TcpCommSocketTest : public QObject
{
    Q_OBJECT

private:
    QTcpSocket* qTestSocket;
    QTcpSocket* qDummySocket;
    QTcpServer* qDummyServer;

//public:
//        TcpCommSocketTest();

public slots:
    void initTestCase();
    void connectDummyServer();
//private Q_SLOTS:

private Q_SLOTS:
    void sendDataTest();
    void test();
//    void cleanupTestCase();
};

#endif // TST_TCPCOMMSOCKET_H
