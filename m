From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Jan 2016 12:19:36 +0100
Subject: [PATCH 2/3] ARM: dts: sama5d4: add labels for watchdog and
 pinctrl nodes
In-Reply-To: <1453293337-16078-3-git-send-email-LW@KARO-electronics.de>
References: <1453293337-16078-1-git-send-email-LW@KARO-electronics.de>
 <1453293337-16078-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160125111936.GC4027@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/01/2016 at 13:35:36 +0100, Lothar Wa?mann wrote :

Ditto, this needs a commit message.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Else,

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>



> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 6c0dc89..fb40014 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1299,7 +1299,7 @@
>  				clocks = <&h32ck>;
>  			};
>  
> -			watchdog at fc068640 {
> +			watchdog: watchdog at fc068640 {
>  				compatible = "atmel,sama5d4-wdt";
>  				reg = <0xfc068640 0x10>;
>  				clocks = <&clk32k>;
> @@ -1351,7 +1351,7 @@
>  			};
>  
>  
> -			pinctrl at fc06a000 {
> +			pinctrl: pinctrl at fc06a000 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
