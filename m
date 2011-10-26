From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Oct 2011 17:10:55 -0200
Subject: [PATCH] ARM: mx31pdk: Add MC13783 RTC support
In-Reply-To: <20111025072034.GR15299@pengutronix.de>
References: <1319482929-28262-1-git-send-email-fabio.estevam@freescale.com>
	<20111025072034.GR15299@pengutronix.de>
Message-ID: <CAOMZO5AN=R6pa11-3JS2XJ_D6tsrSbO-=54J4+FFy4UL32t3hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/10/25 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

>> - ? ? .flags ?= MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
>> + ? ? .flags ?= MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MC13XXX_USE_RTC,
> ok in principle but (I think mfd in) next touches this already:
>
> ? ? ? ?$ git show next/master:arch/arm/mach-imx/mach-mx31_3ds.c | grep USE_TOUCH
> ? ? ? ? ? ? ? ?.flags ?= MC13XXX_USE_TOUCHSCREEN,

Ok, I will wait for this change to reach Sascha's tree first and then
I will repost this patch.

Regards,

Fabio Estevam
