From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Sep 2017 14:49:11 +0200
Subject: [PATCH] arm64: dts: marvell: 37xx: remove empty line
In-Reply-To: <20170918133349.27304-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 18 Sep 2017 15:33:49 +0200")
References: <20170918133349.27304-1-antoine.tenart@free-electrons.com>
Message-ID: <87efr1pmbc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 18 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Cosmetic patch removing an empty line at the end of the NB pinctrl node.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 8c0cf7efac65..55609a2de138 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -183,7 +183,6 @@
>  					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> -
>  				};
>  
>  				xtalclk: xtal-clk {
> -- 
> 2.13.5
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
