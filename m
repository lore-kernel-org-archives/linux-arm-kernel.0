From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 13 Feb 2015 09:43:43 +0100
Subject: [PATCH 08/14] pinctrl: Add pinctrl driver for STM32 MCUs
In-Reply-To: <CAMuHMdXfAENN5EB6nFJdf3bJPJ+=41Po22NKrQWdwkyf5nFXpw@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CAMuHMdXfAENN5EB6nFJdf3bJPJ+=41Po22NKrQWdwkyf5nFXpw@mail.gmail.com>
Message-ID: <CALszF6D1LzvMqO_LibeWAZmdT=OiiWAvHurNQHCSv3d-Lo+qtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-12 21:37 GMT+01:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> --- a/drivers/pinctrl/Kconfig
>> +++ b/drivers/pinctrl/Kconfig
>> @@ -125,6 +125,15 @@ config PINCTRL_ST
>>         select PINCONF
>>         select GPIOLIB_IRQCHIP
>>
>> +config PINCTRL_STM32
>> +       bool "STMicroelectronics STM32 pinctrl driver"
>> +       depends on OF
>
> depends on ARCH_STM32 || COMPILE_TEST

Ok, I agree.

It will be part of the v2.

Thanks,
Maxime
