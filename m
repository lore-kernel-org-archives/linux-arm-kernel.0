From: csd@broadcom.com (Christian Daudt)
Date: Fri, 30 Aug 2013 16:16:55 -0700
Subject: [PATCH v7 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1377882914-30152-3-git-send-email-markus.mayer@linaro.org>
References: <1377882914-30152-1-git-send-email-markus.mayer@linaro.org>
 <1377882914-30152-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <522127E7.6090501@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-30 10:15 AM, Markus Mayer wrote:
> Turn on the bcm281xx GPIO driver in the kernel configuration.
> ---
>   arch/arm/mach-bcm/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index f112895..5819126 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -9,7 +9,7 @@ config ARCH_BCM
>   	select CLKSRC_OF
>   	select GENERIC_CLOCKEVENTS
>   	select GENERIC_TIME
> -	select GPIO_BCM
> +	select GPIO_BCM_KONA
>   	select SPARSE_IRQ
>   	select TICK_ONESHOT
>   	help
Reviewed-by: Christian Daudt <csd@broadcom.com>

  Thanks,
    csd
