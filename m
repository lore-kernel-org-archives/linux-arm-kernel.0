From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 05:47:33 -0700
Subject: [PATCH] ARM: OMAP2: Add missing include of linux/gpio.h
In-Reply-To: <1306845769.27719.1.camel@phoenix>
References: <1306845769.27719.1.camel@phoenix>
Message-ID: <20110531124733.GG11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Lin <axel.lin@gmail.com> [110531 05:39]:
> I got some build error like below while executing "make omap2plus_defconfig".
> 
>   CC      arch/arm/mach-omap2/board-2430sdp.o
> arch/arm/mach-omap2/board-2430sdp.c: In function 'omap_2430sdp_init':
> arch/arm/mach-omap2/board-2430sdp.c:247: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
> arch/arm/mach-omap2/board-2430sdp.c:247: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/board-2430sdp.c:247: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-omap2/board-2430sdp.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> This patch fixes the build error.

Can you please update this to also remove the wrong mach/gpio.h include?

Thanks,

Tony
