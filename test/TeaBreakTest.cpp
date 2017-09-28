#include <QtTest/QtTest>
#include <QSignalSpy>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "../src/TeaBreak.h"
#include "Mocks/TeaBreak.h"

using namespace ::testing;

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

