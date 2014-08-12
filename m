From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 12 Aug 2014 19:05:09 +0200
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable SBS battery support
In-Reply-To: <1407779837-10981-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1407779837-10981-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <5085566.VKH3IuqYyi@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 11, 2014 07:57:17 PM Javier Martinez Canillas wrote:
> Many Exynos5 boards (e.g: Snow, Peach Pit and Pi) have
> a SBS-compliant gas gauge battery. Enable to built it
> so the needed support is available for these boards.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Thanks for updating the patch.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
> Changes since v1:
>  - Don't build it as a module since is the exception in exynos_defconfig.
>    Suggested by Bartlomiej Zolnierkiewicz.
> 
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index fc7d168..c390bb9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_I2C_S3C2410=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_POWER_SUPPLY=y
> +CONFIG_BATTERY_SBS=y
>  CONFIG_CHARGER_TPS65090=y
>  # CONFIG_HWMON is not set
>  CONFIG_THERMAL=y
