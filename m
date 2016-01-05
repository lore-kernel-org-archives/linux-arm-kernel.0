From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 5 Jan 2016 09:38:13 +0800
Subject: [PATCH] ARM: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
In-Reply-To: <1451877536-21603-1-git-send-email-shawn.lin@rock-chips.com>
References: <1451877536-21603-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <568B1E85.1040604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?01?04? 11:18, Shawn Lin wrote:
> dw_mmc driver never use this macro, so remove it from
> zx_defconfig
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>   arch/arm/configs/zx_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
> index b200bb0..ab683fb 100644
> --- a/arch/arm/configs/zx_defconfig
> +++ b/arch/arm/configs/zx_defconfig
> @@ -83,7 +83,6 @@ CONFIG_MMC=y
>   CONFIG_MMC_UNSAFE_RESUME=y
>   CONFIG_MMC_BLOCK_MINORS=16
>   CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>

Reviewed-by: Jun Nie <jun.nie@linaro.org>
