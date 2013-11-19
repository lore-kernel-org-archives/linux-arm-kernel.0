From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 18 Nov 2013 21:07:56 -0800
Subject: [PATCH v3 2/2] ARM: bcm281xx: watchdog configuration
In-Reply-To: <1384824250-16727-3-git-send-email-markus.mayer@linaro.org>
References: <1384824250-16727-1-git-send-email-markus.mayer@linaro.org>
 <1384824250-16727-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <528AF22C.8060907@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 05:24 PM, Markus Mayer wrote:
> This commit enables the watchdog driver for the BCM281xx family of SoCs.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/configs/bcm_defconfig |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 6e49310..8b98e11 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -130,3 +130,6 @@ CONFIG_CRC_ITU_T=y
>   CONFIG_CRC7=y
>   CONFIG_XZ_DEC=y
>   CONFIG_AVERAGE=y
> +CONFIG_WATCHDOG=y
> +CONFIG_BCM_KONA_WDT=y
> +CONFIG_BCM_KONA_WDT_DEBUG=y
>
