#include "stm32l4xx_hal.h"
#include "stm32l4xx_ll_gpio.h"
#include "stm32l4xx_ll_utils.h"

int main(void)
{
  __HAL_RCC_GPIOC_CLK_ENABLE();
  LL_Init1msTick(4000000);

  LL_GPIO_InitTypeDef GPIO_InitStruct;
  LL_GPIO_StructInit(&GPIO_InitStruct);

  GPIO_InitStruct.Pin = LL_GPIO_PIN_8;
  GPIO_InitStruct.Mode = LL_GPIO_MODE_OUTPUT;
  GPIO_InitStruct.Speed = LL_GPIO_SPEED_FREQ_LOW;
  GPIO_InitStruct.OutputType = LL_GPIO_OUTPUT_PUSHPULL;
  GPIO_InitStruct.Pull = LL_GPIO_PULL_NO;

  LL_GPIO_Init(GPIOC, &GPIO_InitStruct);
  
  GPIO_InitStruct.Pin = LL_GPIO_PIN_9;
  LL_GPIO_Init(GPIOC, &GPIO_InitStruct);

  while(1) {
    LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_8);
    LL_mDelay(250);
    LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_9);
    LL_mDelay(250);
  }
}
