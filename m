From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 12 Dec 2011 09:10:28 +0800
Subject: [PATCH] ARM: remove header files included more than once
In-Reply-To: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
References: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <CAN1soZyaDO1dFTuG-5AgNGEHua6pi_W7VQ24yxyV1+dadK-vdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 12:25 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> checkincludes.pl complains about these:
> ? ? ? ?linux/debugfs.h
> ? ? ? ?linux/dma-mapping.h
> ? ? ? ?linux/gpio.h
> ? ? ? ?linux/sched.h
> ? ? ? ?linux/slab.h
> ? ? ? ?plat/common.h
> ? ? ? ?plat/i2c.h
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> ?arch/arm/mach-bcmring/dma.c ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-ks8695/leds.c ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-mmp/tavorevb.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-msm/board-msm7x30.c ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-msm/board-qsd8x50.c ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-omap2/board-ldp.c ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-omap2/io.c ? ? ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c ?| ? ?1 -
> ?arch/arm/mach-pxa/pxa25x.c ? ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-pxa/pxa27x.c ? ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-pxa/saarb.c ? ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-shmobile/board-ag5evm.c ? ? ? | ? ?1 -
> ?arch/arm/mach-ux500/board-mop500-u8500uib.c | ? ?1 -
> ?arch/arm/plat-omap/clock.c ? ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/plat-samsung/dev-backlight.c ? ? ? | ? ?1 -
> ?16 files changed, 0 insertions(+), 16 deletions(-)
>

Hi Omar,

Thanks for your patch. Could you help to split your patches into small
pieces? Since different people are handling for different files. For
example, I can help to handle files in arch-pxa. But I can't handle
other files.

Best Regards
Haojian
