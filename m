From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 18:09:53 -0800
Subject: [PATCH v2 resend] OMAP4: Pandaboard: Add omap_reserve
	functionality
In-Reply-To: <1291793964-26769-1-git-send-email-raghuveer.murthy@ti.com>
References: <1291793964-26769-1-git-send-email-raghuveer.murthy@ti.com>
Message-ID: <20101218020952.GO5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Raghuveer Murthy <raghuveer.murthy@ti.com> [101207 23:31]:
> This patch adds omap_reserve functionality to board-omap4panda.c.
> Helps in the reserving boot time memory in SDRAM, used here for
> framebuffer allocation.
> 
> This patch is in similar lines to commit id 71ee7dad9b6991, from
> Russell king
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index da24745..0ccc24f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,
>  	.init_irq	= omap4_panda_init_irq,
>  	.init_machine	= omap4_panda_init,
>  	.timer		= &omap_timer,

Thanks applying.

Tony
