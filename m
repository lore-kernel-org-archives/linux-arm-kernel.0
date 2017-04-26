From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Apr 2017 12:26:04 +0200
Subject: [PATCH v4 2/7] arm64: marvell: enable the Armada 37xx pinctrl
 driver
In-Reply-To: <d5015ded3a76ae4b1d2d1ef43ab4cc2e51050a03.1491405475.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 5 Apr 2017 17:18:03 +0200")
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <d5015ded3a76ae4b1d2d1ef43ab4cc2e51050a03.1491405475.git-series.gregory.clement@free-electrons.com>
Message-ID: <87vapr8nyb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., avril 05 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> This commit makes sure the driver for the Armada 37xx pin controller is
> enabled.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/arm64

Thanks,

Gregory

> ---
>  arch/arm64/Kconfig.platforms | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 129cc5ae4091..9aa71a3f3f50 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -103,8 +103,13 @@ config ARCH_MVEBU
>  	select ARMADA_AP806_SYSCON
>  	select ARMADA_CP110_SYSCON
>  	select ARMADA_37XX_CLK
> +	select GPIOLIB
> +	select GPIOLIB_IRQCHIP
>  	select MVEBU_ODMI
>  	select MVEBU_PIC
> +	select OF_GPIO
> +	select PINCTRL
> +	select PINCTRL_ARMADA_37XX
>  	help
>  	  This enables support for Marvell EBU familly, including:
>  	   - Armada 3700 SoC Family
> -- 
> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
