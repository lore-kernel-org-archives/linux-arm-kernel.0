From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 17:42:51 +0100
Subject: [PATCH] ARM: at91/dt: fix lcdck declaration
In-Reply-To: <1425486360-21799-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425486360-21799-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54F7360B.1070308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/03/2015 17:26, Boris Brezillon a ?crit :
> lcdck clk is assigned id 3 and not 4.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
and squashed into previous one.

Thanks!

> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index aa4b829..1273af4 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -461,7 +461,7 @@
>  
>  					lcdck: lcdck {
>  						#clock-cells = <0>;
> -						reg = <4>;
> +						reg = <3>;
>  						clocks = <&mck>;
>  					};
>  
> 


-- 
Nicolas Ferre
