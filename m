From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 13 Feb 2017 12:06:56 +0800
Subject: [linux-sunxi] [PATCH 1/8] ARM: sunxi_defconfig: Enable simple
 panel
In-Reply-To: <20170211174405.28395-2-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
 <20170211174405.28395-2-plaes@plaes.org>
Message-ID: <CAGb2v67WP1yPZEDTJd=kDR6uittTBNb1b3oXf_1dAg+4o=tsnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 1:43 AM, Priit Laes <plaes@plaes.org> wrote:
> From: Jonathan Liu <net147@gmail.com>
>

This needs a commit message about why these need to be enabled, like

"Most Allwinner tablets use the same design of a dumb LCD panel coupled
 with a PWM controlled backlight."

Also the subject does not mention CONFIG_BACKLIGHT_PWM being enabled.

> Signed-off-by: Jonathan Liu <net147@gmail.com>

Since you are resending the patch, you must also add your SoB.

ChenYu

> ---
>  arch/arm/configs/sunxi_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index da92c25..7abe6a4 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -153,3 +153,7 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_CRYPTO_DEV_SUN4I_SS=y
> +CONFIG_BACKLIGHT_CLASS_DEVICE=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> +CONFIG_BACKLIGHT_PWM=y
> +CONFIG_DRM_PANEL_SIMPLE=y
> --
> 2.9.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
