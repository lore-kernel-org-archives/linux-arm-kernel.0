From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 15:08:38 -0700
Subject: [PATCH v2 3/3] ARM: dts: AM4372: update hdq compatible property
In-Reply-To: <1425293374-30878-4-git-send-email-vigneshr@ti.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
 <1425293374-30878-4-git-send-email-vigneshr@ti.com>
Message-ID: <20150316220837.GN12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [150302 02:53]:
> This patch updates hdq node compatible property to "ti,am4372-hdq".
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Looks like this is safe to apply even with the driver changes pending
as the driver is currently only parsing ti,omap3-1w property.
So applying this patch into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am4372.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 1943fc333e7c..ae0e8c15a6df 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -884,7 +884,7 @@
>  		};
>  
>  		hdq: hdq at 48347000 {
> -			compatible = "ti,am43xx-hdq";
> +			compatible = "ti,am4372-hdq";
>  			reg = <0x48347000 0x1000>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&func_12m_clk>;
> -- 
> 1.9.1
> 
