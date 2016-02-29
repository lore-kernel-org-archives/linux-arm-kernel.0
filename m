From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 10:58:22 +0800
Subject: [PATCH 1/2] ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
In-Reply-To: <1456325867-5309-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456325867-5309-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20160229025822.GO22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 03:57:46PM +0100, Michael Grzeschik wrote:
> @@ -169,12 +167,11 @@ CONFIG_RTC_DRV_IMXDI=y
>  CONFIG_RTC_DRV_MC13XXX=y
>  CONFIG_RTC_DRV_MXC=y
>  CONFIG_DMADEVICES=y
> -CONFIG_IMX_SDMA=y
>  CONFIG_IMX_DMA=y
> +CONFIG_IMX_SDMA=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> -CONFIG_EXT4_FS=y

I guess that Arnd's comment about keeping CONFIG_EXT4_FS and dropping
the other two applies here too?

Shawn

>  # CONFIG_DNOTIFY is not set
>  CONFIG_VFAT_FS=y
>  # CONFIG_PROC_PAGE_MONITOR is not set
> @@ -187,6 +184,5 @@ CONFIG_NLS_CODEPAGE_437=m
>  CONFIG_NLS_CODEPAGE_850=m
>  CONFIG_NLS_ISO8859_1=y
>  CONFIG_NLS_ISO8859_15=m
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_FONTS=y
>  CONFIG_FONT_8x8=y
> -- 
> 2.7.0
> 
> 
