#include <stdio.h>
#include <stdint.h>
#include <gd32f4xx_usart.h>
#include "demo_project.h"
#include "bsp_uart.h"
#include "FreeRTOS.h"
#include "task.h"

void task_demo(void * pvParameter)
{
	while(1)
    {
        printf("hello arm gcc compile config\r\n");
		vTaskDelay(2000);
    }
}

int main(void)
{
    init_printf();
    printf("make by logic.bai\r\n");
    printf("demo_project_version:%d.%d.%d\r\n",
            demo_project_VERSION_MAJOR,
            demo_project_VERSION_MINOR,
            demo_project_VERSION_PATCH);

    xTaskCreate(task_demo, "freertos_task_demo", 64, ( void * ) NULL, 1, NULL);

    vTaskStartScheduler();

    return 0;
}
