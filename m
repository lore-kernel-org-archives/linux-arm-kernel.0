From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Oct 2013 15:26:49 +0800
Subject: [PATCHv5][ 11/11] ARM: imx_v4_v5_defconfig: Enable gpio
 regulator and gpio button/keyboard.
In-Reply-To: <1382517617-14260-2-git-send-email-denis@eukrea.com>
References: <1382517617-14260-1-git-send-email-denis@eukrea.com>
 <1382517617-14260-2-git-send-email-denis@eukrea.com>
Message-ID: <20131024072644.GF11466@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 10:40:17AM +0200, Denis Carikli wrote:
> The eukrea mbimxsd25 has a gpio regulator for enabling its
>   LCD display, it also has a gpio button.
> 
> We enable the respective drivers in order to be able to use theses
>   features with this configuration.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied this one, thanks.

Shawn

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index e958ebe..6309ee5 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -91,6 +91,7 @@ CONFIG_SMSC911X=y
>  CONFIG_SMSC_PHY=y
>  # CONFIG_INPUT_MOUSEDEV is not set
>  CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_IMX=y
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=y
> @@ -118,6 +119,7 @@ CONFIG_IMX2_WDT=y
>  CONFIG_MFD_MC13XXX_SPI=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_MC13783=y
>  CONFIG_REGULATOR_MC13892=y
>  CONFIG_MEDIA_SUPPORT=y
> -- 
> 1.7.9.5
> 
