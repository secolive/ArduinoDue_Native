#include <Arduino.h>
#include "SPI.h"

#define SERIAL_SPEED 115200

#define USE_SCREEN
//#define ADAFRUIT_GFX_LIB

#ifdef USE_SCREEN
#ifdef ADAFRUIT_GFX_LIB
#include "Adafruit_GFX.h"
#include "Adafruit_ILI9341.h"
#include <Fonts/FreeMono9pt7b.h>
#else

#include <ILI9341_due.h>
#include <fonts/roboto16.h>

#endif

#define SHIELD_PIN_TFT_DC 26
#define SHIELD_PIN_TFT_CS 10
#define SHIELD_PIN_TFT_nRST 25
#endif//USE_SCREEN

#define SHIELD_PIN_LED_L 14
#define SHIELD_PIN_LED_R 15


#ifdef USE_SCREEN
#ifdef ADAFRUIT_GFX_LIB
// Use hardware SPI (on Uno, #13, #12, #11) and the above for CS/DC
Adafruit_ILI9341 tft = Adafruit_ILI9341(SHIELD_PIN_TFT_CS, SHIELD_PIN_TFT_DC);
#else
ILI9341_due tft = ILI9341_due(SHIELD_PIN_TFT_CS, SHIELD_PIN_TFT_DC, SHIELD_PIN_TFT_nRST);
#endif

void initScreen() {
#ifdef ADAFRUIT_GFX_LIB
    tft.begin();

     // read diagnostics (optional but can help debug problems)
    uint8_t x = tft.readcommand8(ILI9341_RDMODE);
    Serial.print("Display Power Mode: 0x"); Serial.println(x, HEX);
    x = tft.readcommand8(ILI9341_RDMADCTL);
    Serial.print("MADCTL Mode: 0x"); Serial.println(x, HEX);
    x = tft.readcommand8(ILI9341_RDPIXFMT);
    Serial.print("Pixel Format: 0x"); Serial.println(x, HEX);
    x = tft.readcommand8(ILI9341_RDIMGFMT);
    Serial.print("Image Format: 0x"); Serial.println(x, HEX);
    x = tft.readcommand8(ILI9341_RDSELFDIAG);
    Serial.print("Self Diagnostic: 0x"); Serial.println(x, HEX);

    tft.setRotation(3);
    tft.setFont(&FreeMono9pt7b);
    tft.setTextColor(ILI9341_WHITE);  tft.setTextSize(1);
#else
    bool result = tft.begin();
    Serial.print("TFT begin successful: ");
    Serial.println(result ? "YES" : "NO");

    tft.setRotation(iliRotation270);
    tft.fillScreen(ILI9341_BLUE);

    tft.setFont(roboto16);
    tft.setTextLetterSpacing(5);
    tft.setTextColor(ILI9341_WHITE, ILI9341_BLUE);
    tft.printAligned(F("Hello World"), gTextAlignMiddleCenter);
#endif
}

#define str(x) #x

void displayScreen() {
    char buffer[32];
    tft.fillScreen(ILI9341_BLACK);

    for(int line=0;line<10;line++) {
#ifdef ADAFRUIT_GFX_LIB
        tft.setCursor(0, line*24+15);
#else
        tft.cursorToXY(0, line*24);
#endif
        switch(line) {
            case 0: sprintf(buffer, "Hello World!"); break;
            case 1: sprintf(buffer, "Serial speed = %d", SERIAL_SPEED); break;
            default: sprintf(buffer, ""); break;
        }
        tft.print(buffer);
    }
}
#endif


void setPioAsPwm(int ulPin);
void pwmWrite(uint32_t ulPin, uint32_t ulValue);


// the setup function runs once when you press reset or power the board
void setup() {
    Serial.begin(SERIAL_SPEED);
    Serial.println("Hello World!");


#ifdef USE_SCREEN
    initScreen();
    displayScreen();
#endif

    // initialize digital pin LED_BUILTIN as an output.
    pinMode(LED_BUILTIN, OUTPUT);

    pinMode(SHIELD_PIN_LED_R, OUTPUT);
    setPioAsPwm(LED_BUILTIN);
    pwmWrite(LED_BUILTIN, 50);
}

// the loop function runs over and over again forever
void loop() {
    digitalWrite(SHIELD_PIN_LED_R, HIGH);
    pwmWrite(LED_BUILTIN, 0);
    delay(1000);

    digitalWrite(SHIELD_PIN_LED_R, LOW);
    pwmWrite(LED_BUILTIN, 128);
    delay(1000);
}

static int _writeResolution = 8;
static uint8_t TCChanEnabled[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

static void TC_SetCMR_ChannelA(Tc *tc, uint32_t chan, uint32_t v) {
    tc->TC_CHANNEL[chan].TC_CMR = (tc->TC_CHANNEL[chan].TC_CMR & 0xFFF0FFFF) | v;
}

static void TC_SetCMR_ChannelB(Tc *tc, uint32_t chan, uint32_t v) {
    tc->TC_CHANNEL[chan].TC_CMR = (tc->TC_CHANNEL[chan].TC_CMR & 0xF0FFFFFF) | v;
}

static inline uint32_t mapResolution(uint32_t value, uint32_t from, uint32_t to) {
    if (from == to)
        return value;
    if (from > to)
        return value >> (from - to);
    else
        return value << (to - from);
}

void setPioAsPwm(int ulPin) {
    PIO_Configure(g_APinDescription[ulPin].pPort,
                  g_APinDescription[ulPin].ulPinType,
                  g_APinDescription[ulPin].ulPin,
                  g_APinDescription[ulPin].ulPinConfiguration);
}


// Right now, PWM output only works on the pins with
// hardware support.  These are defined in the appropriate
// pins_*.c file.  For the rest of the pins, we default
// to digital output.
void pwmWrite(uint32_t ulPin, uint32_t ulValue) {
    //uint32_t attr = g_APinDescription[ulPin].ulPinAttribute;


    // We use MCLK/2 as clock.
    const uint32_t TC = VARIANT_MCK / 2 / 4; //TC_FREQUENCY;

    // Map value to Timer ranges 0..255 => 0..TC
    ulValue = mapResolution(ulValue, _writeResolution, TC_RESOLUTION);
    ulValue = ulValue * TC;
    ulValue = ulValue / TC_MAX_DUTY_CYCLE;

    // Setup Timer for this pin
    ETCChannel channel = g_APinDescription[ulPin].ulTCChannel;
    static const uint32_t channelToChNo[] = {0, 0, 1, 1, 2, 2, 0, 0, 1, 1, 2, 2, 0, 0, 1, 1, 2, 2};
    static const uint32_t channelToAB[] = {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0};
    static Tc *channelToTC[] = {
            TC0, TC0, TC0, TC0, TC0, TC0,
            TC1, TC1, TC1, TC1, TC1, TC1,
            TC2, TC2, TC2, TC2, TC2, TC2};
    static const uint32_t channelToId[] = {0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8};
    uint32_t chNo = channelToChNo[channel];
    uint32_t chA = channelToAB[channel];
    Tc *chTC = channelToTC[channel];
    uint32_t interfaceID = channelToId[channel];

    if (!TCChanEnabled[interfaceID]) {
        pmc_enable_periph_clk(TC_INTERFACE_ID + interfaceID);
        TC_Configure(chTC, chNo,
                     TC_CMR_TCCLKS_TIMER_CLOCK1 |
                     TC_CMR_WAVE |         // Waveform mode
                     TC_CMR_WAVSEL_UP_RC | // Counter running up and reset when equals to RC
                     TC_CMR_EEVT_XC0 |     // Set external events from XC0 (this setup TIOB as output)
                     TC_CMR_ACPA_CLEAR | TC_CMR_ACPC_CLEAR |
                     TC_CMR_BCPB_CLEAR | TC_CMR_BCPC_CLEAR);
        TC_SetRC(chTC, chNo, TC);
    }

    if (ulValue == 0) {
        if (chA)
            TC_SetCMR_ChannelA(chTC, chNo, TC_CMR_ACPA_CLEAR | TC_CMR_ACPC_CLEAR);
        else
            TC_SetCMR_ChannelB(chTC, chNo, TC_CMR_BCPB_CLEAR | TC_CMR_BCPC_CLEAR);
    } else {
        if (chA) {
            TC_SetRA(chTC, chNo, ulValue);
            TC_SetCMR_ChannelA(chTC, chNo, TC_CMR_ACPA_CLEAR | TC_CMR_ACPC_SET);
        } else {
            TC_SetRB(chTC, chNo, ulValue);
            TC_SetCMR_ChannelB(chTC, chNo, TC_CMR_BCPB_CLEAR | TC_CMR_BCPC_SET);
        }
    }
    if ((g_pinStatus[ulPin] & 0xF) != PIN_STATUS_PWM) {
        //setPioAsPwm(ulPin);
        g_pinStatus[ulPin] = (g_pinStatus[ulPin] & 0xF0) | PIN_STATUS_PWM;
    }
    if (!TCChanEnabled[interfaceID]) {

        TC_Start(chTC, chNo);
        TCChanEnabled[interfaceID] = 1;
    }
    return;

}


