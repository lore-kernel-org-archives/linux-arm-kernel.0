From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 13 Feb 2018 13:08:19 +0000
Subject: [PATCH v5 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
In-Reply-To: <1518457475-4480-15-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-15-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB0895970E6725F954D1A97E4CC0F60@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

what do you think about enabling the watchdog in multi_v7_defconfig as a module?

Thanks,
Fab

> Subject: [PATCH v5 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
>
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v4->v5:
> * no change
>
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 578434c..d5cdad8 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -132,6 +132,7 @@ CONFIG_CPU_THERMAL=y
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_DA9063_WATCHDOG=y
> +CONFIG_RENESAS_WDT=y
>  CONFIG_MFD_AS3711=y
>  CONFIG_MFD_DA9063=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
