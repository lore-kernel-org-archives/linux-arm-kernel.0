From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Sep 2012 02:01:21 +0200
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Add DA9052 regulator support
In-Reply-To: <1348702057-2351-3-git-send-email-festevam@gmail.com>
References: <1348702057-2351-1-git-send-email-festevam@gmail.com>
 <1348702057-2351-3-git-send-email-festevam@gmail.com>
Message-ID: <201209270201.21930.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add DA9052 regulator support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Makes sense

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig index 66aa7a6..67620d6 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -142,10 +142,12 @@ CONFIG_GPIO_SYSFS=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
> +CONFIG_MFD_DA9052_I2C=y
>  CONFIG_MFD_MC13XXX_SPI=y
>  CONFIG_MFD_MC13XXX_I2C=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_DA9052=y
>  CONFIG_REGULATOR_MC13783=y
>  CONFIG_REGULATOR_MC13892=y
>  CONFIG_MEDIA_SUPPORT=y

Best regards,
Marek Vasut
