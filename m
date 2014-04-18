From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 18:14:50 +0200
Subject: [PATCH 0/3] ARM: at91: improve at91sam9m10g45ek support
In-Reply-To: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53514F7A.40502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2014 00:15, Alexandre Belloni :
> Here are a few DT improvements for the at91sam9m10g45ek.
> 
> The first patch corrects the ADC support for the at91sam9g45.
> 
> The second patch adds ADC and touchscreen support to the at91sam9m10g45ek.
> 
> The last one corrects the PWM polarity after the polarity got right in the
> driver, following patch "PWM: atmel-pwm: Fix polarity handling"
> 
> 
> Alexandre Belloni (3):
>   ARM: at91/dt: sam9g45: improve ADC/touchscreen support
>   ARM: at91/dt: at91sam9m10g45ek: add ADC and touchscreen support
>   ARM: at91/dt: at91sam9m10g45ek PWM leds polarity is inversed

Ok, nice: the whole series stacked on top of at91-3.16-dt. Thanks.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


>  arch/arm/boot/dts/at91sam9g45.dtsi     | 33 +++++++++++++++++++++++++++++++--
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 20 ++++++++++++++++++--
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 


-- 
Nicolas Ferre
