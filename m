From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 16:22:43 +0000
Subject: [PATCH v2 3/4] ARM: sti: Provide DT nodes for SSC[0..4]
In-Reply-To: <1417534844-25080-4-git-send-email-lee.jones@linaro.org>
References: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
 <1417534844-25080-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20150121162243.GG22024@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

Can you ping these up please?

> The Synchronous Serial Controller is used to provide SPI.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> index 50637f5..90bc090 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -275,5 +275,59 @@
>  
>  			status = "disabled";
>  		};
> +
> +		spi at 9840000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9840000 0x110>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "ssc";
> +			pinctrl-0 = <&pinctrl_spi0_default>;
> +			pinctrl-names = "default";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9841000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9841000 0x110>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9842000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9842000 0x110>;
> +			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9843000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9843000 0x110>;
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9844000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9844000 0x110>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
