From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 7 Apr 2015 21:22:31 +0200
Subject: [PATCH 1/2] ARM: at91/dt: sam9x5: add pinctrl for pwm0
In-Reply-To: <1428415884-30662-2-git-send-email-g.portay@overkiz.com>
References: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
 <1428415884-30662-2-git-send-email-g.portay@overkiz.com>
Message-ID: <20150407192231.GW20669@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ga?l,

On 07/04/2015 at 16:11:23 +0200, Ga?l PORTAY wrote :
> Defines the pinctrl configurations for PWM0.
> 
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index d221179..08ed53d 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -463,6 +463,52 @@
>  					};
>  				};
>  
> +				pwm0 {
> +					pinctrl_pwm0_pwm0_0: pwm0_pwm0-0 {
> +						atmel,pins =
> +							<AT91_PIOB 11 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB11 periph B */
                                           please drop those useless comments --^

Else, I'm fine with that patch.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
