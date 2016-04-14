From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 14 Apr 2016 08:22:06 -0400
Subject: [PATCH] ARM: multi_v7_defconfig: enable Denali NAND controller
In-Reply-To: <1460620464-15896-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460620464-15896-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <570F8B6E.7040303@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Masahiro,

On 04/14/2016 03:54 AM, Masahiro Yamada wrote:
> This NAND controller device is used on UniPhier SoCs (and I know
> it is also used on SoC FPGA).
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2823490..ef1d642 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -183,6 +183,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_DENALI_DT=y
>  CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_NAND_BRCMNAND=y
>  CONFIG_MTD_NAND_VF610_NFC=y
> 

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
