From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 15:38:56 +0200
Subject: [PATCH] arm64: dts: marvell: use new bindings for xor clocks on
 ap806
In-Reply-To: <20170620063838.3003-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Tue, 20 Jun 2017 08:38:38 +0200")
References: <20170620063838.3003-1-antoine.tenart@free-electrons.com>
Message-ID: <87k2464w3z.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mar., juin 20 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> New bindings are used for the system controller on the ap806, which
> means all clock properties must be converted. Use the new bindings in
> the xor nodes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index ff1964d314de..02e5aff48c81 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -159,7 +159,7 @@
>  				reg = <0x400000 0x1000>,
>  				      <0x410000 0x1000>;
>  				msi-parent = <&gic_v2m0>;
> -				clocks = <&ap_syscon 3>;
> +				clocks = <&ap_clk 3>;
>  				dma-coherent;
>  			};
>  
> @@ -168,7 +168,7 @@
>  				reg = <0x420000 0x1000>,
>  				      <0x430000 0x1000>;
>  				msi-parent = <&gic_v2m0>;
> -				clocks = <&ap_syscon 3>;
> +				clocks = <&ap_clk 3>;
>  				dma-coherent;
>  			};
>  
> @@ -177,7 +177,7 @@
>  				reg = <0x440000 0x1000>,
>  				      <0x450000 0x1000>;
>  				msi-parent = <&gic_v2m0>;
> -				clocks = <&ap_syscon 3>;
> +				clocks = <&ap_clk 3>;
>  				dma-coherent;
>  			};
>  
> @@ -186,7 +186,7 @@
>  				reg = <0x460000 0x1000>,
>  				      <0x470000 0x1000>;
>  				msi-parent = <&gic_v2m0>;
> -				clocks = <&ap_syscon 3>;
> +				clocks = <&ap_clk 3>;
>  				dma-coherent;
>  			};
>  
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
