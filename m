From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 May 2014 19:56:56 +0800
Subject: [PATCH 2/6] ARM: dts: i.MX25: remove disabled property of
 usbmisc unit
In-Reply-To: <1399615879-30781-3-git-send-email-s.hauer@pengutronix.de>
References: <1399615879-30781-1-git-send-email-s.hauer@pengutronix.de>
 <1399615879-30781-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140509115654.GF2870@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 08:11:15AM +0200, Sascha Hauer wrote:
> It's a unit only used by the usb devices. No need to enable them
> manually.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx25.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 83fdda3..bd3ac9b 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -520,7 +520,6 @@
>  				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
>  				clock-names = "ipg", "ahb", "per";
>  				reg = <0x53ff4600 0x00f>;
> -				status = "disabled";

I already queued a patch from Fabio, which has this change.

https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=f415153c0ecaae1f4515df35d2c6d055ed97909c

Shawn

>  			};
>  
>  			dryice at 53ffc000 {
> -- 
> 2.0.0.rc0
> 
