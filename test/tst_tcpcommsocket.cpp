#include "tst_tcpcommsocket.h"
#include <QtTest/QtTest>
#include <QSignalSpy>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace ::testing;

//TcpCommSocketTest::TcpCommSocketTest() { }
void TcpCommSocketTest::connectDummyServer()
{
   std::cout << "connection attempt" << endl;
   qDummySocket = qDummyServer->nextPendingConnection();
}

void TcpCommSocketTest::initTestCase()
{
    qDummySocket = NULL;
    qDummyServer = new QTcpServer();
    qDummyServer->listen( QHostAddress("127.0.0.1"), 9000 );
    connect( qDummyServer, SIGNAL(newConnection()), SLOT(connectDummyServer()) );

    qTestSocket = new QTcpSocket();
    qTestSocket->connectToHost( QHostAddress("127.0.0.1"), 9000 );

    QVERIFY( qTestSocket->waitForConnected( 5000 ) );
    QVERIFY( qTestSocket->state() == QTcpSocket::ConnectedState );

    qApp->processEvents();
}
//void TcpCommSocketTest::cleanupTestCase() { }

void TcpCommSocketTest::sendDataTest()
{
    QVERIFY( qDummySocket != NULL );
}

void TcpCommSocketTest::test()
{
   QCOMPARE(1, 1);
}

QTEST_MAIN(TcpCommSocketTest);
/*
int main(int argc, char *argv[])
{
   testing::InitGoogleTest(&argc, argv);
   testing::InitGoogleMock(&argc, argv);
   return RUN_ALL_TESTS();
}
*/

