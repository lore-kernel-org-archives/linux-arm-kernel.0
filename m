From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jan 2010 15:20:14 +0000
Subject: [PATCH 2/2] mx31ads: Provide an IRQ range to the WM835x on the
	1133-EV1 module
In-Reply-To: <20100105135728.GL6923@pengutronix.de>
Message-ID: <20100105152014.GA3752@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 02:57:28PM +0100, Sascha Hauer wrote:

> I just had a look how other architectures handle this and I like it how
> pxa does it:

Yeah, my thinking here was to achieve the same thing with something more
like the existing i.MX code plus a bit more whitespace for legibility -
the end result is pretty much the same but a little less dense.  You'd
wind up with an ordered stack of these ifdef blocks very much like those
that PXA has.  I'm not that fussed either way, really, but I do like a
bit more whitespace.
