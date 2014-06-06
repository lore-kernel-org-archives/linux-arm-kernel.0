From: nm@ti.com (Nishanth Menon)
Date: Fri, 6 Jun 2014 09:33:19 -0500
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Message-ID: <5391D12F.4020501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 05:36 AM, Mark Brown wrote:
[...]
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0ba4826..524b027 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -12,7 +12,6 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> -	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select OMAP_INTERCONNECT
>  	select PM_OPP if PM

For OMAP portion:
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
