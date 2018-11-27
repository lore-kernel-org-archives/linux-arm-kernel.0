From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 11:32:53 +0100
Subject: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
In-Reply-To: <20181127083523.pciie2gyaplrwiey@pengutronix.de>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
 <20181127083523.pciie2gyaplrwiey@pengutronix.de>
Message-ID: <20181127103253.ubbjjy2ji6sxc7xs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 09:35:23AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> > On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > > +  - clocks: From common clock binding, handle to the parent clock.
> > > +  - clock-names: Must contain the clock names described just above.
> > 
> > [...]
> > 
> > You seem to have used mux-0 and mux-1 for the clock names. I guess we
> > don't have to use a name there, we can simply use the position to find
> > out (as long as it's documented in the binding)
> 
> I also wondered if the driver relies on the fact that the second clock
> is the faster running one. Is this sensible?

Not really, I'm not sure we can make those expectations in the DT
binding, especially since clock rate can change at runtime.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/9a1f0822/attachment.sig>
