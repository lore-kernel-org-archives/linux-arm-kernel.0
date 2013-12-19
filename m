From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Dec 2013 16:50:12 +0100
Subject: [PATCH] i2c: at91: document clock properties
In-Reply-To: <1387295644-7382-1-git-send-email-b.brezillon@overkiz.com>
References: <1387295644-7382-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52B315B4.6000906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/2013 16:54, Boris BREZILLON :
> Document the clock properties required by the at91 i2c bus driver.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> index b689a0d..4fade84 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -9,6 +9,7 @@ Required properties :
>  - interrupts: interrupt number to the cpu.
>  - #address-cells = <1>;
>  - #size-cells = <0>;
> +- clocks: phandles to input clocks.
>  
>  Optional properties:
>  - Child nodes conforming to i2c bus binding
> @@ -21,6 +22,7 @@ i2c0: i2c at fff84000 {
>  	interrupts = <12 4 6>;
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> +	clocks = <&twi0_clk>;
>  
>  	24c512 at 50 {
>  		compatible = "24c512";
> 


-- 
Nicolas Ferre
