#include <QObject>

//https://stackoverflow.com/questions/19129133/qt-signals-and-slots-permissions#19130831
//Signals are protected in Qt4 but are public in Qt5
#     define signals public

// Real class we want to mock
class TeaBreak : public QObject
{
Q_OBJECT
public:
    virtual ~TeaBreak() {}

    // Return minutes taken to make the drinks
    int morningTea();

//signals:
signals:
    void chargePercentChanged();

private:
    virtual int makeCoffee(bool milk, double sugars) = 0;
    virtual int makeHerbalTea() = 0;
};

