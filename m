From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 Mar 2015 11:42:22 +0100
Subject: [PATCH 1/2] ARM: dts: hummingboard: enable PCF8523 RTC support
In-Reply-To: <E1YSWZG-0002As-7I@rmk-PC.arm.linux.org.uk>
References: <E1YSWZG-0002As-7I@rmk-PC.arm.linux.org.uk>
Message-ID: <1425379342.3146.39.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 02.03.2015, 20:03 +0000 schrieb Russell King:
> Enable the commented out PCF8523 RTC support for Hummingboard pro
> base boards.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> For acks please.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> 
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 674cb237298f..93588c987d2c 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -113,16 +113,13 @@
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hummingboard_i2c1>;
> -
> -	/*
> -	 * Not fitted on Carrier-1 board... yet
>  	status = "okay";
>  
> +	/* Pro baseboard model */
>  	rtc: pcf8523 at 68 {
>  		compatible = "nxp,pcf8523";
>  		reg = <0x68>;
>  	};
> -	 */
>  };
>  
>  &i2c2 {
