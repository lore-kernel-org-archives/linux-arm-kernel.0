From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 10 Aug 2015 08:53:34 +0200
Subject: [RFC PATCH 0/3] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <20150805073117.GP5161@pengutronix.de>
References: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
 <20150805073117.GP5161@pengutronix.de>
Message-ID: <20150810065334.GC2635@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Aug 05, 2015 at 09:31:17AM +0200, Sascha Hauer wrote:
> On Fri, Jul 31, 2015 at 05:08:07PM +0200, Ludovic Desroches wrote:
> > Hi,
> > 
> > Following our discussion, I send an RFC version of my driver. RFC because it is
> > not totally achieved, some cleanup and feature addition is needed.
> > 
> > At least, we could discuss about the 'core' part. I have used the pinmux
> > property as Mediatek driver. Patch 3 is the internal dt files we are using.
> 
> As you can imagine I am fine with the binding, so I can add my acked-by
> once you send a non-RFC version.
>

Great, I'm glad to hear that.
 
> The only thing I never understood is what's so special about GPIOs that
> they have to bypass the pinctrl framework and instead a gpio_request
> magically translates a gpio into a pin.

Not sure to really understand your concern here... Do you mean I could
get rid of gpio_request_enable()?

> Wouldn't it make sense to at
> least add the pins in their GPIO mode to
> arch/arm/boot/dts/sama5d2-pinfunc.h?

It is done, PIN_PA0 could be used for this purpose.

Regards

Ludovic
