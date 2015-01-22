From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 Jan 2015 12:01:06 +0100
Subject: [PATCH v2] ARM: at91: sama5d4: dts: change the nand compatible
 string
In-Reply-To: <1421923305-10088-1-git-send-email-josh.wu@atmel.com>
References: <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
 <1421923305-10088-1-git-send-email-josh.wu@atmel.com>
Message-ID: <54C0D872.6010005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/01/2015 11:41, Josh Wu a ?crit :
> As we introduce a new "atmel,sama5d4-nand" compatible string for sama5d4,
> so we need to apply it for sama5d4 chip.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Brian,
I suppose that it makes sense to keep this patch with the previous one.
So, can you take it in your tree?

Otherwise, it can take the at91 -> arm-soc route.

Bye,

> ---
> 
> Changes in v2:
> - still keep the old rm9200 nand compatible string for compatible old driver.
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 1b0f30c..e40b1da 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -267,7 +267,7 @@
>  		};
>  
>  		nand0: nand at 80000000 {
> -			compatible = "atmel,at91rm9200-nand";
> +			compatible = "atmel,sama5d4-nand", "atmel,at91rm9200-nand";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> 


-- 
Nicolas Ferre
