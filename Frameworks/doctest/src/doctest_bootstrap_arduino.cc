#include <Arduino.h>

#define SERIAL_SPEED 115200

extern int doctest_impl(int argc, char** argv);

void setup()
{
    Serial.begin(SERIAL_SPEED);
}

void loop()
{
    doctest_impl(0, 0);
    delay(1000*60);
}
