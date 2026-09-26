#include "__preprocessor__.h"
#include "led.h"
#include "FreeRTOS.h"
#include "task.h"

void Task_Blink()
{
    for(;;)
    {
        led_toggle();
        vTaskDelay(250);
    }
}

int main()
{
    led_init();

    // Utworzenie zadania
    xTaskCreate(Task_Blink, "Blink Task", 128, NULL, 1, NULL);

    // Start systemu RTOS
    vTaskStartScheduler();

    return 0;
}
