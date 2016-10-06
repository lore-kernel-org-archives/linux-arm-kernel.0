From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Oct 2016 16:56:06 +0200
Subject: [PATCH] ARM: dts: armada-xp-rn2120: drop wrong compatible for i2c0
In-Reply-To: <20160929185221.23194-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 29 Sep 2016 20:52:21
 +0200")
References: <20160929185221.23194-1-u.kleine-koenig@pengutronix.de>
Message-ID: <874m4pwmpl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On jeu., sept. 29 2016, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> The compatible is supposed to be "marvell,mv78230-i2c", "marvell,mv64xxx-i2c",
> as provided by armada-xp.dtsi.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied on mvebu/dt-4.10

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> index d19f44c70925..3e930fdbaabc 100644
> --- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -97,7 +97,6 @@
>  			};
>  
>  			i2c at 11000 {
> -				compatible = "marvell,mv64xxx-i2c";
>  				clock-frequency = <400000>;
>  				status = "okay";
>  
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
