#ifndef MOCKTEABREAK_H
#define MOCKTEABREAK_H

#include "TeaBreak.h"

// Mock class
class MockTeaBreak : public TeaBreak
{
public:
    MOCK_METHOD2(makeCoffee,    int(bool milk, double sugars));
    MOCK_METHOD0(makeHerbalTea, int());
};

#endif
