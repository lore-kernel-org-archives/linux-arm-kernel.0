From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 31 May 2011 21:23:49 +0800
Subject: [PATCH v2] ARM: OMAP2: Add missing include of linux/gpio.h
In-Reply-To: <20110531131812.GP11352@atomide.com>
References: <1306846544.30148.1.camel@phoenix>
	<20110531131812.GP11352@atomide.com>
Message-ID: <BANLkTi=JtnWtoWUOytjcqqvYsQde_SLr9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/31 Tony Lindgren <tony@atomide.com>:
> * Axel Lin <axel.lin@gmail.com> [110531 05:51]:
>> I got some build error like below while executing "make omap2plus_defconfig".
>>
>> ? CC ? ? ?arch/arm/mach-omap2/board-2430sdp.o
>> arch/arm/mach-omap2/board-2430sdp.c: In function 'omap_2430sdp_init':
>> arch/arm/mach-omap2/board-2430sdp.c:247: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
>> arch/arm/mach-omap2/board-2430sdp.c:247: error: (Each undeclared identifier is reported only once
>> arch/arm/mach-omap2/board-2430sdp.c:247: error: for each function it appears in.)
>>
>> This patch fixes the build error by include linux/gpio.h instead of mach/gpio.h.
>
> Does this happen with next?
Yes, I build the kernel with today's linux-next tree.
>
> Will queue as a fix anyways.
Thanks,
Axel
