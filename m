From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 31 Jan 2015 12:15:19 +0100
Subject: [PATCH] ARM: dts: at91sam9260: fix usart pinctrl
In-Reply-To: <54CB6A16.4070601@microbit.se>
References: <54CB6A16.4070601@microbit.se>
Message-ID: <20150131111519.GI4164@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Added the maintainers in Cc)

On 30/01/2015 at 12:25:10 +0100, Jonas Andersson wrote :
> 
> Corrected pins used by usart3.
> 
> Signed-off-by: Jonas Andersson <jonas@microbit.se>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi
> b/arch/arm/boot/dts/at91sam9260.dtsi
> index dd1313c..16ccfd9 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -489,12 +489,12 @@
> 
>                      pinctrl_usart3_rts: usart3_rts-0 {
>                          atmel,pins =
> -                            <AT91_PIOB 8 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> /* PC8 periph B */
> +                            <AT91_PIOC 8 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> /* PC8 periph B */
>                      };
> 
>                      pinctrl_usart3_cts: usart3_cts-0 {
>                          atmel,pins =
> -                            <AT91_PIOB 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> /* PC10 periph B */
> +                            <AT91_PIOC 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> /* PC10 periph B */
>                      };
>                  };
> 
> -- 
> 1.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
