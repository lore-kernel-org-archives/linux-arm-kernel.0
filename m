From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Nov 2010 23:26:45 +0100
Subject: [PATCHv3 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <20101109221213.GC16938@pengutronix.de>
References: <1288972551-21877-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288972551-21877-2-git-send-email-Dinh.Nguyen@freescale.com>
	<20101109220207.GH6017@pengutronix.de>
	<20101109221213.GC16938@pengutronix.de>
Message-ID: <20101109222645.GJ6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 11:12:13PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> > > -	if (!cpu_is_mx51())
> > > +	if (!cpu_is_mx51() || !cpu_is_mx53())
> > >  		return 0;
> > 
> > The code below runs for every SoC except i.MX51 and i.MX53. This is
> > surely not what you want.
> Hmm, for i.MX51 !cpu_is_mx53() is true, so the return 0 is always taken,
> isn't it? :-)

Gna, I remember I ran in this trap not so long time ago ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
