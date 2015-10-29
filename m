From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 29 Oct 2015 11:32:35 +0900
Subject: [RFC PATCH v8 10/10] arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
In-Reply-To: <1442385808-1433-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <1442385808-1433-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <56318543.3090900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All.

Is there any other opinion about this patch?


Best Regards,
Jaehoon Chung

On 09/16/2015 03:43 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/zx_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
> index b200bb0..ab683fb 100644
> --- a/arch/arm/configs/zx_defconfig
> +++ b/arch/arm/configs/zx_defconfig
> @@ -83,7 +83,6 @@ CONFIG_MMC=y
>  CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_MMC_BLOCK_MINORS=16
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> 
