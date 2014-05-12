From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 May 2014 11:08:56 +0200
Subject: [PATCH 1/2] ARM: at91: add PWM pinctrl to SAMA5D3
In-Reply-To: <53708EFF.1030604@atmel.com>
References: <a5a0a9b8090f80f40daf3a13849b3961d9d617d6.1399642907.git.nicolas.ferre@atmel.com>
 <20140510091017.GA22329@piout.net> <53708EFF.1030604@atmel.com>
Message-ID: <20140512090855.GA29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 at 11:06:07 +0200, Nicolas Ferre wrote :
> On 10/05/2014 11:10, Alexandre Belloni :
> > Hi Nicolas,
> > 
> > On 09/05/2014 at 15:44:27 +0200, Nicolas Ferre wrote :
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >> ---
> >>  arch/arm/boot/dts/sama5d3.dtsi | 82 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 82 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> >> index 9caa06b3641e..ed7943745f23 100644
> >> --- a/arch/arm/boot/dts/sama5d3.dtsi
> >> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> >> @@ -583,6 +583,88 @@
> >>  					};
> >>  				};
> >>  
> >> +				pwm0 {
> >> +					pinctrl_pwm0_pwmh0_0: pwm0_pwmh0-0 {
> >> +						atmel,pins =
> >> +							<AT91_PIOA 20 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA20 periph B, conflicts with ISI_D4 and LCDDAT20 */
> > 
> > Didn't we decide at some point to stop adding comments for the pinctrl ?
> > At least, I would say that "PA20 periph B" doesn't add any useful
> > information.
> 
> Yes, we said that for the description and you are right saying that
> saying again the pin configuration doesn't make sense. On the other
> hand, I tend to like the "conflicts with ..." part of it (and it is
> automatically generated).
> 
> So, should we keep this part?
> 

Yes, it adds real information.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
