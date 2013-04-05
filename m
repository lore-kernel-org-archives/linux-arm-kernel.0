From: marex@denx.de (Marek Vasut)
Date: Fri, 5 Apr 2013 08:38:42 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Set the sdcard as non-removable
In-Reply-To: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
References: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
Message-ID: <201304050838.42571.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Pereira da Silva,

> The imx23-olinuxino sdcard doesn't support card detect.
> 
> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts
> b/arch/arm/boot/dts/imx23-olinuxino.dts index e7484e4..03f55c2 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -29,6 +29,7 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a 
&mmc0_pins_fixup>;
>  				bus-width = <4>;
> +				non-removable;
>  				status = "okay";
>  			};

The card on mx23 olinuxino seems perfectly removable to me ... on all possible 
models and even prototypes and hybrids too ;-)

Best regards,
Marek Vasut
