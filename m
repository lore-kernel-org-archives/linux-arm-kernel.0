From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 13:17:38 -0800
Subject: [PATCH 1/2] ARM: dts: omap4: Add elm node
In-Reply-To: <1446066137-11527-2-git-send-email-fcooper@ti.com>
References: <1446066137-11527-1-git-send-email-fcooper@ti.com>
 <1446066137-11527-2-git-send-email-fcooper@ti.com>
Message-ID: <20151130211738.GR2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [151028 14:02]:
> Add device tree entry for the error location module.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Applying this one into omap-for-v4.5/dt thanks.

Tony


>  arch/arm/boot/dts/omap4.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 5a206c1..a40eb23 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -348,6 +348,14 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		elm: elm at 48078000 {
> +			compatible = "ti,am3352-elm";
> +			reg = <0x48078000 0x2000>;
> +			interrupts = <4>;
> +			ti,hwmods = "elm";
> +			status = "disabled";
> +		};
> +
>  		gpmc: gpmc at 50000000 {
>  			compatible = "ti,omap4430-gpmc";
>  			reg = <0x50000000 0x1000>;
> -- 
> 2.6.1
> 
