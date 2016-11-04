From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 04 Nov 2016 13:33:04 +0100
Subject: [PATCH] ARM: dts: armada-370-rn102: drop specification of
 compatible for i2c0
In-Reply-To: <20161020191527.27679-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 20 Oct 2016 21:15:27
 +0200")
References: <20161020191527.27679-1-u.kleine-koenig@pengutronix.de>
Message-ID: <87d1ibo267.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On jeu., oct. 20 2016, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> The compatible string is already provided by armada-370.dtsi.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied on mvebu/dt

Thanks,

Gregory

> ---
> Hello,
>
> this is the same as commit 43940ce3b089962f97de544d72b783bd146ef362 that
> currently is in next, just for rn102 instead of rn104.
>
> Best regards
> Uwe
>
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index 39181b3fa90d..3ca6330a1752 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -120,7 +120,6 @@
>  			};
>  
>  			i2c at 11000 {
> -				compatible = "marvell,mv64xxx-i2c";
>  				clock-frequency = <100000>;
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
