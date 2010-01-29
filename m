From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 Jan 2010 09:42:31 +0100
Subject: [PATCH] mx35: add a missing comma in a pad definition
In-Reply-To: <1264708239-12219-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1264708239-12219-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100129084231.GM19551@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 08:50:39PM +0100, Uwe Kleine-K?nig wrote:
> Reported-by: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx35.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

ok

Sascha

> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> index 00b0ac1..c88d407 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> @@ -671,7 +671,7 @@
>  #define MX35_PAD_LD8__SDMA_SDMA_DEBUG_PC_8			IOMUX_PAD(0x634, 0x1d0, 6, 0x0,   0, NO_PAD_CTRL)
>  
>  #define MX35_PAD_LD9__IPU_DISPB_DAT_9				IOMUX_PAD(0x638, 0x1d4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX35_PAD_LD9__GPIO2_9					IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4  0, NO_PAD_CTRL)
> +#define MX35_PAD_LD9__GPIO2_9					IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4, 0, NO_PAD_CTRL)
>  #define MX35_PAD_LD9__SDMA_SDMA_DEBUG_PC_9			IOMUX_PAD(0x638, 0x1d4, 6, 0x0,   0, NO_PAD_CTRL)
>  
>  #define MX35_PAD_LD10__IPU_DISPB_DAT_10				IOMUX_PAD(0x63c, 0x1d8, 0, 0x0,   0, NO_PAD_CTRL)
> -- 
> 1.6.6
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
