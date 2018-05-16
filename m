From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 16 May 2018 20:08:54 +0200
Subject: [PATCH] arm64: defconfig: enable the Armada thermal driver
In-Reply-To: <20180514145859.22812-1-antoine.tenart@bootlin.com> (Antoine
 Tenart's message of "Mon, 14 May 2018 16:58:59 +0200")
References: <20180514145859.22812-1-antoine.tenart@bootlin.com>
Message-ID: <87o9hf1nih.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., mai 14 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> This patch enables the Armada thermal driver to support thermal
> management on Marvell EBU Armada SoCs (7K,8K).
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/arm64

Thanks,

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ecf613761e78..8f0707bcc54d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -343,6 +343,7 @@ CONFIG_SENSORS_INA2XX=m
>  CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
> +CONFIG_ARMADA_THERMAL=y
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_EXYNOS_THERMAL=y
>  CONFIG_RCAR_GEN3_THERMAL=y
> -- 
> 2.17.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
