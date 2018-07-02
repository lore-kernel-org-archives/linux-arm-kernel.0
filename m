From: groeck@google.com (Guenter Roeck)
Date: Mon, 2 Jul 2018 07:42:40 -0700
Subject: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
In-Reply-To: <20180702102201.13461-3-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-3-enric.balletbo@collabora.com>
Message-ID: <CABXOdTfj3d2S0WA93zimry46mNLnGKLTidPTnsjaCuLfhuEnGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol has
> been renamed and lost the MFD_ prefix, so update all configs to the new
> config symbol name.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  arch/arm/configs/exynos_defconfig   | 4 ++--
>  arch/arm/configs/multi_v7_defconfig | 4 ++--
>  arch/arm/configs/pxa_defconfig      | 4 ++--
>  arch/arm64/configs/defconfig        | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 85b2369d6b20..27ea6dfcf2f2 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -155,8 +155,8 @@ CONFIG_THERMAL_EMULATION=y
>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MFD_CROS_EC=y
> -CONFIG_MFD_CROS_EC_I2C=y
> -CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_CROS_EC_I2C=y
> +CONFIG_CROS_EC_SPI=y
>  CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
>  CONFIG_MFD_MAX77693=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8f6be1982545..be732f382418 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -490,8 +490,8 @@ CONFIG_MFD_AC100=y
>  CONFIG_MFD_AXP20X_I2C=y
>  CONFIG_MFD_AXP20X_RSB=y
>  CONFIG_MFD_CROS_EC=m
> -CONFIG_MFD_CROS_EC_I2C=m
> -CONFIG_MFD_CROS_EC_SPI=m
> +CONFIG_CROS_EC_I2C=m
> +CONFIG_CROS_EC_SPI=m
>  CONFIG_MFD_DA9063=m
>  CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index 5655a1cee87d..6bb506edb1f5 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -398,8 +398,8 @@ CONFIG_MFD_AS3711=y
>  CONFIG_MFD_BCM590XX=m
>  CONFIG_MFD_AXP20X=y
>  CONFIG_MFD_CROS_EC=m
> -CONFIG_MFD_CROS_EC_I2C=m
> -CONFIG_MFD_CROS_EC_SPI=m
> +CONFIG_CROS_EC_I2C=m
> +CONFIG_CROS_EC_SPI=m
>  CONFIG_MFD_ASIC3=y
>  CONFIG_PMIC_DA903X=y
>  CONFIG_HTC_EGPIO=y
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f9a186f6af8a..3ec0feccdd62 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -372,8 +372,8 @@ CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
>  CONFIG_MFD_AXP20X_RSB=y
>  CONFIG_MFD_CROS_EC=y
> -CONFIG_MFD_CROS_EC_I2C=y
> -CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_CROS_EC_I2C=y
> +CONFIG_CROS_EC_SPI=y
>  CONFIG_MFD_CROS_EC_CHARDEV=m
>  CONFIG_MFD_EXYNOS_LPASS=m
>  CONFIG_MFD_HI6421_PMIC=y
> --
> 2.18.0
>
