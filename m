From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 18:56:35 +0100
Subject: [PATCH 11/11] ARM: STi: STiH407: Add spi default pinctrl groups.
In-Reply-To: <1441991194-11948-12-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-12-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911175635.GG18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> Now we have default pinconfig groups for each SPI
> controller ensure it is used by the SPI controller
> node.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>
 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 838b812..94a2fec 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -381,6 +381,8 @@
>  			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi1_default>;
>  
>  			status = "disabled";
>  		};
> @@ -391,6 +393,8 @@
>  			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi2_default>;
>  
>  			status = "disabled";
>  		};
> @@ -401,6 +405,8 @@
>  			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi3_default>;
>  
>  			status = "disabled";
>  		};
> @@ -411,6 +417,8 @@
>  			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi4_default>;
>  
>  			status = "disabled";
>  		};
> @@ -422,6 +430,8 @@
>  			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_sysin>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi10_default>;
>  
>  			status = "disabled";
>  		};
> @@ -432,6 +442,8 @@
>  			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_sysin>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi11_default>;
>  
>  			status = "disabled";
>  		};
> @@ -442,6 +454,8 @@
>  			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk_sysin>;
>  			clock-names = "ssc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi12_default>;
>  
>  			status = "disabled";
>  		};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
