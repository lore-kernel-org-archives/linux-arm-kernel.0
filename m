From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 19 Sep 2016 18:10:55 +0800
Subject: [PATCH 1/2] arm64: defconfig: enable I2C and DW MMC controller on
 rockchip platform
In-Reply-To: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
References: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <d82132bc-1348-acb6-0b67-418a4969cf7a@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi :

   Respected maintainers, is there some suggestions for this patch?


On 2016?09?07? 19:46, Andy Yan wrote:
> I2C and MMC are very basic modules for a board to bootup, as I2C always
> used to configure PMIC and MMC devices often used to store filesytem.
> So enable them here to let the rockchip based arm64 boards can bootup.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index eadf485..427b6dc 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -222,6 +222,7 @@ CONFIG_I2C_QUP=y
>   CONFIG_I2C_TEGRA=y
>   CONFIG_I2C_UNIPHIER_F=y
>   CONFIG_I2C_RCAR=y
> +CONFIG_I2C_RK3X=y
>   CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SPI=y
>   CONFIG_SPI_ORION=y
> @@ -323,6 +324,7 @@ CONFIG_MMC_SPI=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_EXYNOS=y
>   CONFIG_MMC_DW_K3=y
> +CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SUNXI=y
>   CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
