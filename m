From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 16:13:29 +0200
Subject: [PATCH 1/5] arm64: defconfig: Enable sound support for Samsung
 Chromebook Plus.
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com> (Enric
 Balletbo i. Serra's message of "Tue, 17 Jul 2018 18:06:06 +0200")
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Message-ID: <87efg0aaye.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric Balletbo,
 
 On mar., juil. 17 2018, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Enable the Rockchip sound driver with MAX98357A/RT5514/DA7219 codecs
> needed for the Samsung Chromebook Plus.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Could you remove me from your destination list for your next version?

I guess you got my name by the get_maintainer script, but for the
defconfig the result is very inaccurate. Indeed, the fact that I update
the defconfig for the SoC I care doesn't mean that I have an expertise
on the other SoC :)

Thanks,

Gregory

> ---
>
>  arch/arm64/configs/defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f9a186f6af8a..4917641060b1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -447,9 +447,20 @@ CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_BCM2835_SOC_I2S=m
> +CONFIG_SND_SOC_ROCKCHIP=m
> +CONFIG_SND_SOC_ROCKCHIP_I2S=m
> +CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
> +CONFIG_SND_SOC_ROCKCHIP_RT5645=m
> +CONFIG_SND_SOC_RK3399_GRU_SOUND=m
>  CONFIG_SND_SOC_SAMSUNG=y
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SOC_AK4613=m
> +CONFIG_SND_SOC_DA7219=m
> +CONFIG_SND_SOC_MAX98357A=m
> +CONFIG_SND_SOC_RL6231=m
> +CONFIG_SND_SOC_RT5514=m
> +CONFIG_SND_SOC_RT5514_SPI=m
> +CONFIG_SND_SOC_RT5645=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_I2C_HID=m
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
