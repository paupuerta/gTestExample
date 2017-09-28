#include <QtTest/QtTest>
#include <QSignalSpy>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

// Simple test, does not use gmock
TEST(Dummy, foobar)
{
    EXPECT_EQ(0, 0);
}

