From: csd@broadcom.com (Christian Daudt)
Date: Tue, 10 Sep 2013 15:32:02 -0700
Subject: [PATCH v9 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1378836423-12467-3-git-send-email-markus.mayer@linaro.org>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <522F9DE2.8080605@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-09-10 11:07 AM, Markus Mayer wrote:
> Turn on the bcm281xx GPIO driver in the kernel configuration.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> ---
>   arch/arm/mach-bcm/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 69d67f7..7f6fca8 100644
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
>   	select CACHE_L2X0
Applied to armsoc/for-3.13/soc

  thanks,
    csd
