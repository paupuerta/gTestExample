#include <QtTest/QtTest>
#include <QSignalSpy>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "../src/example.h"

using namespace ::testing;

// Simple test, does not use gmock
TEST(Dummy, foobar)
{
    EXPECT_EQ(0, 0);
}

// Mock class
class MockTeaBreak : public TeaBreak
{
public:
    MOCK_METHOD2(makeCoffee,    int(bool milk, double sugars));
    MOCK_METHOD0(makeHerbalTea, int());
};

/*
class TeaBreakTest : public Test
{
public:
    TeaBreakTest () { }

protected:
    //Dependancies

    //Class Under Test
    TeaBreak m_TeaBreak;
};*/

using ::testing::Return;
using ::testing::_;

// Mocked test
TEST(TeaBreakTest, MorningTea)
{
    MockTeaBreak  teaBreak;
    EXPECT_CALL(teaBreak, makeCoffee(_,_))
       .WillOnce(Return(2))
       .WillOnce(Return(1));

    EXPECT_CALL(teaBreak, makeHerbalTea())
       .WillOnce(Return(3));

    EXPECT_LE(teaBreak.morningTea(), 6);
}

TEST(TeaBreakTest, EmitsEvent)
{
    NiceMock<MockTeaBreak> teaBreak;
    //MockTeaBreak teaBreak;
    QSignalSpy spy(&teaBreak, SIGNAL(chargePercentChanged()));
    emit teaBreak.chargePercentChanged();
    ASSERT_EQ(1, spy.count());
}


int main(int argc, char *argv[])
{
    testing::InitGoogleTest(&argc, argv);
    testing::InitGoogleMock(&argc, argv);
    return RUN_ALL_TESTS();
}

