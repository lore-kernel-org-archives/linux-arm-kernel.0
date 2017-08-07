From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Aug 2017 16:41:00 +0100
Subject: [PATCH v2 3/3] ARM: dts: at91: sama5d2: use sama5d2 compatible
 string for SMC
In-Reply-To: <20170718132220.25018-4-ludovic.desroches@microchip.com>
References: <20170718132220.25018-1-ludovic.desroches@microchip.com>
 <20170718132220.25018-4-ludovic.desroches@microchip.com>
Message-ID: <20170807154100.hvl5ua3vdqttghfj@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jul 2017, Ludovic Desroches wrote:

> A new compatible string has been introduced for sama5d2 SMC to allow to
> manage the registers mapping change.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index cc06da394366..3e6e2dbc2595 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1048,7 +1048,7 @@
>  			};
>  
>  			hsmc: hsmc at f8014000 {
> -				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
> +				compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
>  				reg = <0xf8014000 0x1000>;
>  				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
>  				clocks = <&hsmc_clk>;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
