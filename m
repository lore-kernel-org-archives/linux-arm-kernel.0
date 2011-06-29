From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Jun 2011 08:27:26 +0200
Subject: [PATCH] ARM: mx53: Fix some interrupts marked as reserved.
In-Reply-To: <1309276716-12828-1-git-send-email-fabio.estevam@freescale.com>
References: <1309276716-12828-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110629062726.GL6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 12:58:36PM -0300, Fabio Estevam wrote:
> Mark the actual interrupt source for some interrupts currently marked as reserved.

applied for next.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/mx53.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
> index 3128af7..5e3c323 100644
> --- a/arch/arm/plat-mxc/include/mach/mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/mx53.h
> @@ -233,7 +233,7 @@
>  #define MX53_INT_ESDHC2	2
>  #define MX53_INT_ESDHC3	3
>  #define MX53_INT_ESDHC4	4
> -#define MX53_INT_RESV5	5
> +#define MX53_INT_DAP	5
>  #define MX53_INT_SDMA	6
>  #define MX53_INT_IOMUX	7
>  #define MX53_INT_NFC	8
> @@ -262,8 +262,8 @@
>  #define MX53_INT_UART1	31
>  #define MX53_INT_UART2	32
>  #define MX53_INT_UART3	33
> -#define MX53_INT_RESV34	34
> -#define MX53_INT_RESV35	35
> +#define MX53_INT_RTC	34
> +#define MX53_INT_PTP	35
>  #define MX53_INT_ECSPI1	36
>  #define MX53_INT_ECSPI2	37
>  #define MX53_INT_CSPI	38
> @@ -293,8 +293,8 @@
>  #define MX53_INT_I2C1	62
>  #define MX53_INT_I2C2	63
>  #define MX53_INT_I2C3	64
> -#define MX53_INT_RESV65	65
> -#define MX53_INT_RESV66	66
> +#define MX53_INT_MLB	65
> +#define MX53_INT_ASRC	66
>  #define MX53_INT_SPDIF	67
>  #define MX53_INT_SIM_DAT	68
>  #define MX53_INT_IIM	69
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
