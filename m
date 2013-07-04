From: csd@broadcom.com (Christian Daudt)
Date: Thu, 4 Jul 2013 09:26:11 -0700
Subject: [PATCH] ARM: bcm281xx: Turn on L2 cache.
In-Reply-To: <1371683718-15026-1-git-send-email-markus.mayer@linaro.org>
References: <1371683718-15026-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <51D5A223.5010107@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-19 04:15 PM, Markus Mayer wrote:
> Turning on the L2 cache for the bcm281xx family.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Acked-by: Christian Daudt <csd@broadcom.com>
> ---
>   arch/arm/mach-bcm/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index f112895..69d67f7 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -12,6 +12,7 @@ config ARCH_BCM
>   	select GPIO_BCM
>   	select SPARSE_IRQ
>   	select TICK_ONESHOT
> +	select CACHE_L2X0
>   	help
>   	  This enables support for system based on Broadcom SoCs.
>   	  It currently supports the 'BCM281XX' family, which includes
applied.
  thanks,
    csd
