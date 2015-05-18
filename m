From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 18 May 2015 14:59:46 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <1431158038-3813-10-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-10-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6C0CR=MGCnPfEy16sRP1vTgw8kUgwjKOzbA1YSc5dtdqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
> The drivers detects whether the time is 16 or 32 bits, and applies a
> 1024 prescaler value if it is 16 bits.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/clocksource/Kconfig       |   8 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/timer-stm32.c | 184 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/clocksource/timer-stm32.c
>

I forgot to as you to also pick this one an its documentation (patch 8).

Best regards,
Maxime
