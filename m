From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 14:48:38 +0800
Subject: [PATCH 2/3] ARM: imx: select HAVE_ARM_ARCH_TIMER if selected
 i.MX7D
In-Reply-To: <1449789132-18976-2-git-send-email-Frank.Li@freescale.com>
References: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
 <1449789132-18976-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20151221064614.GE4703@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 07:12:11AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> i.MX7D Supported ARCH Timer.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0ac180f..061dea4 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -563,6 +563,7 @@ config SOC_IMX7D
>  	select ARM_GIC
>  	select HAVE_IMX_ANATOP
>  	select HAVE_IMX_MMDC
> +	select HAVE_ARM_ARCH_TIMER

Please sort these selections alphabetically.

Shawn

>  	help
>  		This enables support for Freescale i.MX7 Dual processor.
>  
> -- 
> 2.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
