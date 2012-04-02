From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Apr 2012 11:21:05 +0200
Subject: [PATCH] efikamx: match machine descriptions with legacy
In-Reply-To: <1329779368-27878-1-git-send-email-hector.oron@gmail.com>
References: <1329779368-27878-1-git-send-email-hector.oron@gmail.com>
Message-ID: <20120402092105.GA27586@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 12:09:28AM +0100, Hector Oron wrote:
>   Rename machine descriptions to match legacy descriptions distributed by
>   manufacturer BSP. This way distributions can do clean upgrades from
>   userspace scripts which check for these values to differentiate platforms
>   with single kernel binaries.
> 
> Signed-off-by: Hector Oron <hector.oron@gmail.com>
> Acked-by: Matt Sealey <matt@genesi-usa.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-mx5/board-mx51_efikamx.c |    3 +--
>  arch/arm/mach-mx5/board-mx51_efikasb.c |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> index 3a5ed2d..fbfccc7 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> @@ -283,8 +283,7 @@ static struct sys_timer mx51_efikamx_timer = {
>  	.init = mx51_efikamx_timer_init,
>  };
>  
> -MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
> -	/* Maintainer: Amit Kucheria <amit.kucheria@linaro.org> */
> +MACHINE_START(MX51_EFIKAMX, "Genesi Efika MX (Smarttop)")
>  	.atag_offset = 0x100,
>  	.map_io = mx51_map_io,
>  	.init_early = imx51_init_early,
> diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
> index 4baf05c..dedbca5 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikasb.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
> @@ -483,7 +483,7 @@ static struct sys_timer mx51_efikasb_timer = {
>  	.init	= mx51_efikasb_timer_init,
>  };
>  
> -MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
> +MACHINE_START(MX51_EFIKASB, "Genesi Efika MX (Smartbook)")
>  	.atag_offset = 0x100,
>  	.map_io = mx51_map_io,
>  	.init_early = imx51_init_early,
> -- 
> 1.7.9
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
