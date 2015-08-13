From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 13 Aug 2015 11:18:10 +0100
Subject: [RFC PATCH v4 6/9] arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
In-Reply-To: <1438843553-24058-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843553-24058-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <55CC6EE2.4070308@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/6/2015 7:45 AM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Wei Xu <xuwei5@hisilicon.com>

> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/hisi_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
> index 5997dbc..b2e340b 100644
> --- a/arch/arm/configs/hisi_defconfig
> +++ b/arch/arm/configs/hisi_defconfig
> @@ -69,7 +69,6 @@ CONFIG_NOP_USB_XCEIV=y
>  CONFIG_MMC=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_MMC_DW_PLTFM=y
>  CONFIG_RTC_DRV_PL031=y
>  CONFIG_DMADEVICES=y
> 

Thanks!

Best Regards,
Wei
