#include "__preprocessor__.h"
#include "led.h"

int main()
{
    led_init();

    toggle_nt(3, 300);

    while (true)
    {
        toggle_t(1000);
    }

    

    return 0;
}
