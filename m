From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jun 2017 18:25:57 +0200
Subject: [PATCH v2 1/3] arm64: dts: marvell: cp110: enable the crypto
 engine at the SoC level
In-Reply-To: <20170615121004.32257-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 15 Jun 2017 14:10:02 +0200")
References: <20170615121004.32257-1-antoine.tenart@free-electrons.com>
Message-ID: <87eful6wve.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 15 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Enable the cryptographic engine at the SoC level on the master cp110.
> This engine is always present and do not depends on any pinmux
> configuration.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index c4294403276b..54cc3fc7b6a4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -245,7 +245,6 @@
>  				"ring2", "ring3", "eip";
>  				clocks = <&cpm_syscon0 1 26>;
>  				dma-mask = <0xff 0xffffffff>;
> -				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
