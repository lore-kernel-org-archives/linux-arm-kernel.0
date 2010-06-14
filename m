From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 Jun 2010 21:08:01 +0100
Subject: Request review of device tree documentation
In-Reply-To: <alpine.LFD.2.00.1006141432530.13427@xanadu.home>
References: <AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
	<4C165FD1.6080505@firmworks.com>
	<alpine.LFD.2.00.1006141311580.13427@xanadu.home>
	<4C1672FF.3060407@firmworks.com>
	<alpine.LFD.2.00.1006141432530.13427@xanadu.home>
Message-ID: <20100614200800.GF10776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 03:40:19PM -0400, Nicolas Pitre wrote:
> On Mon, 14 Jun 2010, Mitch Bradley wrote:

> > Arranging for a JTAG dongle to appear at the customer site, then 
> > getting it set up and the necessary software installed and configured 
> > on a suitable host system, typically requires several days at best, 
> > plus potentially a lot of fiddling depending on what sort of host 
> > system the customer happens to have.

> Well, if I may use the SheevaPlug as an example, the actual FT2232 chip 
> currently used in most of those USB-JTAG dongle was provided directly on 
> the board.  So you have this standard mini-B type USB connector on the 
> side of the device from which you get both a serial console and a JTAG 
> interface.  All you need is a standard USB cable, just like the one you 
> get with a MP3 player or a digital camera, so there are plenty of those 
> around.

The other thing here is of course that if JTAG is a problem serial or
other console access is likely to also be a problem - it's likely to not
be physically present and at least as painful to set up as JTAG.
