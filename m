From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jan 2010 16:47:19 +0100
Subject: [PATCH 2/2] mx31ads: Provide an IRQ range to the WM835x on the
	1133-EV1 module
In-Reply-To: <20100105152014.GA3752@rakim.wolfsonmicro.main>
References: <20100105135728.GL6923@pengutronix.de>
	<20100105152014.GA3752@rakim.wolfsonmicro.main>
Message-ID: <20100105154719.GO6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 03:20:14PM +0000, Mark Brown wrote:
> On Tue, Jan 05, 2010 at 02:57:28PM +0100, Sascha Hauer wrote:
> 
> > I just had a look how other architectures handle this and I like it how
> > pxa does it:
> 
> Yeah, my thinking here was to achieve the same thing with something more
> like the existing i.MX code plus a bit more whitespace for legibility -
> the end result is pretty much the same but a little less dense.  You'd
> wind up with an ordered stack of these ifdef blocks very much like those
> that PXA has.  I'm not that fussed either way, really, but I do like a
> bit more whitespace.

Feel free to add more whitespaces. What I like about pxa is that it
makes clear that MXC_BOARD_IRQS is defined exactly in this file (no
additional #ifndef MXC_BOARD_IRQS) and that it describes how people
should add additional irqs.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
