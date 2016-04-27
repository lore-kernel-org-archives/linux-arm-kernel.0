From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Apr 2016 10:05:32 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: add slow clock to watchdog node
In-Reply-To: <1461676307-16059-1-git-send-email-nicolas.ferre@atmel.com>
References: <1461676307-16059-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160427080532.GB3264@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/2016 at 15:11:47 +0200, Nicolas Ferre wrote :
> As the watchdog timer needs the slow clock, add it to the currently defined
> wdt node.
> 
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 43015c2ad395..84eed47ffb0a 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1050,6 +1050,7 @@
>  				compatible = "atmel,sama5d4-wdt";
>  				reg = <0xf8048040 0x10>;
>  				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
> +				clocks = <&clk32k>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
