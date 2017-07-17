From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Mon, 17 Jul 2017 12:11:54 +0200
Subject: [PATCH 4/8] ARM: l2x0: add arm,ecc-enable property for aurora
In-Reply-To: <dab7ef10fce7419e87f70145a960e287@svr-chch-ex1.atlnz.lc>
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-5-jlu@pengutronix.de>
 <20170630150051.GZ4902@n2100.armlinux.org.uk>
 <dab7ef10fce7419e87f70145a960e287@svr-chch-ex1.atlnz.lc>
Message-ID: <1500286314.6946.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-07-02 at 22:02 +0000, Chris Packham wrote:
> > > index d9650c1788f4..6316e673307a 100644
> > > --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> > > +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> > > @@ -76,6 +76,8 @@ Optional properties:
> > > ???? specified to indicate that such transforms are precluded.
> > > ?? - arm,parity-enable : enable parity checking on the L2 cache
> > > (L220 or PL310).
> > > ?? - arm,parity-disable : disable parity checking on the L2 cache
> > > (L220 or PL310).
> > > +- arm,ecc-enable : enable ECC protection on the L2 cache
> > > +- arm,ecc-disable : disable ECC protection on the L2 cache
> > 
> > Why should this be prefixed by a vendor of "arm" ?
> > 
> 
> I was following the parity-enable example. But I'm guessing this
> should?either be "aurora" or "marvell" any preference?

I'd prefer 'marvell' as they are the vendor and the prefix is already
in vendor-prefixes.txt. If nobody objects, i'll change it to
marvell,ecc-* in v2.
--?
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
