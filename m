From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 8 Feb 2016 18:50:25 +0100
Subject: [PATCH v5 0/9] Add STM32 pinctrl/GPIO driver
In-Reply-To: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6D_2zcg0SsV8HQ8kiSMypau1SV28L08fuz+Pziqyu8QKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-03 12:04 GMT+01:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> Hi Linus,
>
> This is the fifth round of STM32 pinctrl series, which is rebased on top of
> v4.5-rc1 and removes no more needed dependency between DT and driver.
>
> Also, it fixes the Makefile so that it is really built when COMPILE_TEST is
> set and not ARCH_STM32.
>
> The STM32 family has 16 pins per GPIO bank, and the number of bank varies
> depending on the model.
>
> Pins can be multiplexed either in GPIO mode, alternate function (up to 15
> functions per pin) or analog (for ADC/DAC).
>
> Changes since v4:
> -----------------
>  - Rebase on v4.5-rc1
>  - Fix compilation breakage due to gpio_chip struct .dev field renaming
>  - Move the macros from includes/dt-bindings to STM32 pinctrl driver directory
> to avoid uneeded dependency between DT and driver.
>  - Fix Makefile so that driver is built with COMPILE_TEST set

Please discard this series, the changes above are being handled on top of v4.

Regards,
Maxime
