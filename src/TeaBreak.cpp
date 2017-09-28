//#include <QObject>
//#include <QtTest/QtTest>
//#include <QSignalSpy>

//#include "gmock/gmock.h"
#include "TeaBreak.h"

// Return minutes taken to make the drinks
    int TeaBreak::morningTea()
    {
        return makeCoffee(true,  1) +
               makeCoffee(false, 0.5) +
               makeHerbalTea();
    }

