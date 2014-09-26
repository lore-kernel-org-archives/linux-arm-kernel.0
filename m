From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 26 Sep 2014 05:30:40 +0000
Subject: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
In-Reply-To: <1409546541-4129-1-git-send-email-Li.Xiubo@freescale.com>
References: <1409546541-4129-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <9dc024498c904d48b3a25430f8d31f29@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I'd like to know the status of this patch.

Our Platforms depend on it.

Thanks,

BRs
Xiubo

> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo at freescale.com]
> Sent: Monday, September 01, 2014 12:42 PM
> To: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c49a775..bf8445c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1687,7 +1687,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>  source "mm/Kconfig"
> 
>  config FORCE_MAX_ZONEORDER
> -	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
> +	int "Maximum zone order"
>  	range 11 64 if ARCH_SHMOBILE_LEGACY
>  	default "12" if SOC_AM33XX
>  	default "9" if SA1111 || ARCH_EFM32
> --
> 1.8.4
