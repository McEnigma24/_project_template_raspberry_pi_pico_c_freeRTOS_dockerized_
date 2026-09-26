#include "pico/stdlib.h"

// Pico W devices use a GPIO on the WIFI chip for the LED,
// so when building for Pico W, CYW43_WL_GPIO_LED_PIN will be defined
#ifdef CYW43_WL_GPIO_LED_PIN
#include "pico/cyw43_arch.h"
#endif

#define my_time ( 100 )

static bool led_state = false;

int pico_led_init(void)
{
    #if defined(PICO_DEFAULT_LED_PIN)
        gpio_init(PICO_DEFAULT_LED_PIN);                // A device like Pico that uses a GPIO for the LED will define PICO_DEFAULT_LED_PIN
        gpio_set_dir(PICO_DEFAULT_LED_PIN, GPIO_OUT);   // so we can use normal GPIO functionality to turn the led on and off
        return PICO_OK;
    #elif defined(CYW43_WL_GPIO_LED_PIN)
        return cyw43_arch_init(); // For Pico W devices we need to initialise the driver etc
    #endif
}

void pico_set_led(bool led_value)
{
    led_state = led_value;
    #if defined(PICO_DEFAULT_LED_PIN)
        gpio_put(PICO_DEFAULT_LED_PIN, led_value); // Just set the GPIO on or off
    #elif defined(CYW43_WL_GPIO_LED_PIN)
        cyw43_arch_gpio_put(CYW43_WL_GPIO_LED_PIN, led_value); // Ask the wifi "driver" to set the GPIO on or off
    #endif
}

void led_init()
{
    hard_assert(pico_led_init() == PICO_OK);
}

void led_toggle()
{
    led_state = !led_state;
    pico_set_led(led_state);
}

void led_toggle_t(int time)
{
    led_toggle();
    sleep_ms(time);
}

void led_toggle_n(int n)
{
    for(int i=0; i<n; i++)
    {
        led_toggle();
        sleep_ms(my_time);
        led_toggle();
        sleep_ms(my_time);
    }
}

void led_toggle_nt(int n, int time)
{
    for(int i=0; i<n; i++)
    {
        led_toggle();
        sleep_ms(time);
        led_toggle();
        sleep_ms(time);
    }
}