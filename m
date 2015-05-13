From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 13:09:38 +0900
Subject: [PATCHv2 1/3] ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN
 for odroidxu3 pmw-fan
In-Reply-To: <1431489174-4479-2-git-send-email-linux.amoon@gmail.com>
References: <1431489174-4479-1-git-send-email-linux.amoon@gmail.com>
 <1431489174-4479-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <5552CE82.9070109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.2015 12:52, Anand Moon wrote:
> Enable CONFIG_SENSORS_PWM_FAN on exynos_defconfig to control fan power on Odroidxu3.

s/Odroidxu3/Odroid XU3/ (or Odroid-XU3, just capitalize the symbol).

Please go back to default length of wrapping commit messages. This one
exceeds it. Default is 75 characters so git log or git show output would
fit in 80 characters terminal.

With these changes you can add my tag:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index d034c96..3c2784f 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -101,6 +101,7 @@ CONFIG_CHARGER_MAX77693=y
>  CONFIG_CHARGER_TPS65090=y
>  CONFIG_HWMON=y
>  CONFIG_SENSORS_LM90=y
> +CONFIG_SENSORS_PWM_FAN=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL=y
> 
