From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 27 Nov 2012 10:58:10 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable twl4030
 SoC audio
In-Reply-To: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <50B48EB2.1040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 02:21 AM, Javier Martinez Canillas wrote:
> Many TI OMAP SoC based boards that uses twl4030 as codec have
> been updated to use the unified audio driver (omap-twl4030)
> since they have similar audio setup.
> 
> So, is good to have it built to add audio support to these boards.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

I also agree that it is a good practice to enable this in the defconfig.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 7c6cbdf..022212c 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -172,6 +172,7 @@ CONFIG_SND_DEBUG=y
>  CONFIG_SND_USB_AUDIO=m
>  CONFIG_SND_SOC=m
>  CONFIG_SND_OMAP_SOC=m
> +CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
>  CONFIG_USB=y
>  CONFIG_USB_DEBUG=y
> 


-- 
P?ter
