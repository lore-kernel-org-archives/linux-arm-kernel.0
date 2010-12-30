From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 10:32:23 +0100
Subject: [PATCH v3 3/8] arm: mx51: define mx51's own MXC_GPIO_IRQS
In-Reply-To: <1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101230093223.GQ14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 12:56:04PM +0800, Richard Zhao wrote:
> mx5 SoCs have different GPIO port count.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  arch/arm/plat-mxc/include/mach/irqs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index 86781f7..769a137 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -29,7 +29,7 @@
>  #define MXC_GPIO_IRQS		(32 * 4)
>  #elif defined CONFIG_ARCH_MX25
>  #define MXC_GPIO_IRQS		(32 * 4)
> -#elif defined CONFIG_ARCH_MX5
> +#elif defined CONFIG_ARCH_MX51
>  #define MXC_GPIO_IRQS		(32 * 4)
>  #elif defined CONFIG_ARCH_MXC91231
>  #define MXC_GPIO_IRQS		(32 * 4)
> -- 
> 1.6.3.3
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
