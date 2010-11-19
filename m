From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Nov 2010 18:34:14 -0200
Subject: [PATCH 1/2] ARM: mx5: introduce SOC_IMX51
In-Reply-To: <20101119192846.GW8942@pengutronix.de>
References: <1290193589-17633-1-git-send-email-fabio.estevam@freescale.com>
	<20101119192846.GW8942@pengutronix.de>
Message-ID: <AANLkTimxVg3o2U=gr5g-aaBFH+-FNzaCgJPC6ugqPcpi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/11/19 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
>> ?config ARCH_MX51
>> ? ? ? bool
>> +
>> +config SOC_IMX51
>> + ? ? bool
>> ? ? ? default y
> Can you please remove this default y and let all MACH_XYZ select it?

Ok, will do as suggested and will send the v2 of this patch after your
patch series hits Sascha?s tree.

I noticed that arch/arm/mach-mx5/Kconfig will conflict later if I base
my patch on top of your tree.

Thanks,

Fabio Estevam
