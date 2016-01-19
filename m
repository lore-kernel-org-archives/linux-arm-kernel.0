From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 Jan 2016 09:42:54 +0100
Subject: [PATCH] ARM: dts: at91: at91sam9n12ek: fix panel compatible string
In-Reply-To: <1453167059-31247-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453167059-31247-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <569DF70E.4070205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/01/2016 02:30, Alexandre Belloni a ?crit :
> Properly use qiaodian as the vendor prefix for the panel
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Yes, this one needs to go in "fixes" for 4.5...

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

> ---
>  arch/arm/boot/dts/at91sam9n12ek.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index ca4ddf86817a..626c67d66626 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -215,7 +215,7 @@
>  	};
>  
>  	panel: panel {
> -		compatible = "qd,qd43003c0-40", "simple-panel";
> +		compatible = "qiaodian,qd43003c0-40", "simple-panel";
>  		backlight = <&backlight>;
>  		power-supply = <&panel_reg>;
>  		#address-cells = <1>;
> 


-- 
Nicolas Ferre
