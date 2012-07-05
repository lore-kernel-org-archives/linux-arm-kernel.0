From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 08:55:06 +0800
Subject: [PATCH 2/2] ARM: mxs: defconfig: Enable CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1341261351-7924-2-git-send-email-festevam@gmail.com>
References: <1341261351-7924-1-git-send-email-festevam@gmail.com>
 <1341261351-7924-2-git-send-email-festevam@gmail.com>
Message-ID: <20120705005504.GG2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 05:35:51PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> With the common clock framework in place, it is useful to enable
> CONFIG_COMMON_CLK_DEBUG option, in order to easily inspect the clock tree.
> 

I'm ambiguous on this.  It does look useful, but on the other hand,
I'm wondering why it hasn't been enabled by framework by default.

Sascha, what's your take on this?

Regards,
Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/mxs_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index 5406c23..caa9ae1 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -111,6 +111,7 @@ CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_DS1307=m
>  CONFIG_DMADEVICES=y
>  CONFIG_MXS_DMA=y
> +CONFIG_COMMON_CLK_DEBUG=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_FSCACHE=m
> -- 
> 1.7.1
> 
