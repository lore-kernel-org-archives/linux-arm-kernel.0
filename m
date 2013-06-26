From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 26 Jun 2013 04:10:57 +0000
Subject: [PATCH 1/2] ARM: configs: Enable TI_EDMA in omap2plus_defconfig
In-Reply-To: <1372210320-7148-1-git-send-email-joelagnel@ti.com>
References: <1372210320-7148-1-git-send-email-joelagnel@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC43DE5@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 07:02:00, Fernandes, Joel wrote:
> From: Joel A Fernandes <agnel.joel@gmail.com>
> 
> Build EDMA in my default to avoid fewer people stepping on their toes

"my default" --> which default. I believe it should be omap2plus defconfig

> with broken DMA on drivers needing EDMA.
> 
> Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index abbe319..7e00deb 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -236,6 +236,7 @@ CONFIG_RTC_DRV_TWL92330=y
>  CONFIG_RTC_DRV_TWL4030=y
>  CONFIG_RTC_DRV_OMAP=y
>  CONFIG_DMADEVICES=y
> +CONFIG_TI_EDMA=y
>  CONFIG_DMA_OMAP=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
