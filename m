From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 18:05:19 +0200
Subject: [PATCH 3/4] ARM: dts: mxs: Add pwm4 muxing options for imx28
In-Reply-To: <1342540787-14930-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1342540787-14930-1-git-send-email-maxime.ripard@free-electrons.com>
 <1342540787-14930-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120717180519.215f8d8d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 17:59:46 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 44ce1fd..0a565ef 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -461,6 +461,15 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				pwm4_pins_a: pwm4 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x31d0 /* MX28_PAD_PWM4__PWM_4 */

Unless my eyes are broken, it seems that the final >; is missing here.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
