From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Feb 2016 13:54:46 -0800
Subject: [PATCH v4 5/5] ARM: multi_v7_defconfig: Enable LP872x regulator
 support
In-Reply-To: <1456663185-14170-6-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-6-git-send-email-contact@paulk.fr>
Message-ID: <20160229215446.GP13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> The LP872x regulator is used in the LG Optimus Black codename sniper to supply
> the external mmc card.

This patch needs to be sent directly to arm at kernel.org to avoid
merge conflicts. I've picked the omap2plus_defconfig related change
into omap-for-v4.6/defconfig.

Regards,

Tony

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8e8b2ac..59d65bd 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -468,6 +468,7 @@ CONFIG_REGULATOR_RK808=y
>  CONFIG_REGULATOR_GPIO=y
>  CONFIG_MFD_SYSCON=y
>  CONFIG_POWER_RESET_SYSCON=y
> +CONFIG_REGULATOR_LP872X=y
>  CONFIG_REGULATOR_MAX14577=m
>  CONFIG_REGULATOR_MAX8907=y
>  CONFIG_REGULATOR_MAX8973=y
> -- 
> 2.6.4
> 
