From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jul 2014 08:36:19 +0900
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable SBS battery support
In-Reply-To: <1406227380-3569-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1406227380-3569-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53D19873.3040806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/14 03:43, Javier Martinez Canillas wrote:
> Many Exynos5 boards (e.g: Snow, Peach Pit and Pi) have
> a SBS-compliant gas gauge battery. Enable it as module
> so the needed support is available for these boards.
>
> Suggested-by: Doug Anderson<dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas<javier.martinez@collabora.co.uk>
> ---
>   arch/arm/configs/exynos_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index fc7d168..c390bb9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
>   CONFIG_I2C_S3C2410=y
>   CONFIG_DEBUG_GPIO=y
>   CONFIG_POWER_SUPPLY=y
> +CONFIG_BATTERY_SBS=m
>   CONFIG_CHARGER_TPS65090=y
>   # CONFIG_HWMON is not set
>   CONFIG_THERMAL=y

Looks good to me.

Olof, since previous exynos_defconfig has been updated in arm-soc and no 
branch for it in my tree at this time, picking this into arm-soc 
directly would be better and you may add my ack on this.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin
