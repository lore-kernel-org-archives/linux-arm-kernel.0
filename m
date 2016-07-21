From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 21 Jul 2016 17:34:03 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable bus frequency scaling with
 DEVFREQ/DEVFREQ-Event
In-Reply-To: <1468546426-4482-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20160715013357epcas1p1f7e365ac861b48a56c029e67b9461d60@epcas1p1.samsung.com>
 <1468546426-4482-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <579088FB.2000101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Could you please pick this patch?

Regards,
Chanwoo Choi

On 2016? 07? 15? 10:33, Chanwoo Choi wrote:
> This patch enables the bus frequency scaling driver with DEVFREQ and
> DEVFREQ-Event framework. This patches already was merged for Odroid-U3/XU3
> ,Trats2 and Rinato/Monk boards.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index a5aa44c56bfe..37052b115a40 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -219,6 +219,16 @@ CONFIG_CROS_EC_CHARDEV=y
>  CONFIG_COMMON_CLK_MAX77686=y
>  CONFIG_COMMON_CLK_MAX77802=y
>  CONFIG_COMMON_CLK_S2MPS11=y
> +CONFIG_PM_DEVFREQ=y
> +CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> +CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> +CONFIG_DEVFREQ_GOV_POWERSAVE=y
> +CONFIG_DEVFREQ_GOV_USERSPACE=y
> +CONFIG_DEVFREQ_GOV_PASSIVE=y
> +CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
> +CONFIG_PM_DEVFREQ_EVENT=y
> +CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
> +CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
>  CONFIG_EXTCON=y
>  CONFIG_EXTCON_MAX14577=y
>  CONFIG_EXTCON_MAX77693=y
> 
