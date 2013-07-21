From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 21 Jul 2013 20:50:23 +0200
Subject: [PATCH 1/6] ARM: dts: i.MX27: Using "wdog_ipg_gate" clock
 source for watchdog
In-Reply-To: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
References: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130721185023.GM29785@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 11:17:54AM +0400, Alexander Shiyan wrote:
> Patch replaces "dummy" clock source for watchdog with "wdog_ipg_gate".
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

The series looks good to me.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  arch/arm/boot/dts/imx27.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 56b8c97..e9d60ab 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -96,7 +96,7 @@
>  				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
>  				reg = <0x10002000 0x1000>;
>  				interrupts = <27>;
> -				clocks = <&clks 0>;
> +				clocks = <&clks 74>;
>  			};
>  
>  			gpt1: timer at 10003000 {
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
