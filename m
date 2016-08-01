From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Aug 2016 17:32:11 +0200
Subject: [PATCH] ARM: dts: at91: sama5d4ek: remove useless lcd_bus
In-Reply-To: <1468433313-8192-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468433313-8192-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <579F6B7B.9050201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/07/2016 20:08, Alexandre Belloni a ?crit :
> lcd_bus has never been mainlined and is replaced by the atmel_hlcdc driver.
> Remove stale nodes.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d4ek.dts | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index 4e98cda97403..f8b96cef5e1a 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -69,26 +69,6 @@
>  
>  	ahb {
>  		apb {
> -			lcd_bus at f0000000 {
> -				status = "okay";
> -
> -				lcd at f0000000 {
> -					status = "okay";
> -				};
> -
> -				lcdovl1 at f0000140 {
> -					status = "okay";
> -				};
> -
> -				lcdovl2 at f0000240 {
> -					status = "okay";
> -				};
> -
> -				lcdheo1 at f0000340 {
> -					status = "okay";
> -				};
> -			};
> -
>  			adc0: adc at fc034000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <
> 


-- 
Nicolas Ferre
