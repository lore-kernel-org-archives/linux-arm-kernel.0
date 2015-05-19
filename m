From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 19 May 2015 16:41:58 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <555B3F80.8070605@linaro.org>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <555B098A.8030202@linaro.org>
 <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
 <6177628.0ZDPLeVyah@wuerfel>
 <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
 <555B3F80.8070605@linaro.org>
Message-ID: <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 15:49 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>
>
> It is not exactly as the initial patch.
>
> I think Arnd is proposing:
>
> config CLKSRC_STM32
>         bool "Clocksource for STM32 SoCs" if COMPILE_TEST
>         select CLKSRC_MMIO
>

Isn't "depends on OF" missing for COMPILE_TEST case?

Other than that, I'm fine with the proposal.
Daniel, is it the case for you too?

Regards,
Maxime
