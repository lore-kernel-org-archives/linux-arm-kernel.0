From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 18 May 2015 13:55:00 +0200
Subject: [PATCH v8 04/16] clocksource/drivers: Add ARM System timer driver
In-Reply-To: <1431158038-3813-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-5-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6BiKwDKejfpVgs6ojTxC4LSRfLSEaszXTGVy7xfbHLHZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> This patch adds clocksource support for ARMv7-M's System timer,
> also known as SysTick.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/clocksource/Kconfig          |  7 ++++
>  drivers/clocksource/Makefile         |  1 +
>  drivers/clocksource/armv7m_systick.c | 79 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/clocksource/armv7m_systick.c
>

Could you consider applying this patch and its dt-bindings
documentation (patch 3/16) on your tree for v4.2?

Thanks in advance,
Maxime
