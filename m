From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Apr 2011 03:44:44 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <1302079304.8718.7.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<BANLkTinDgAwu7jg+rciMUU19fj+TKPRwmg@mail.gmail.com>
	<1302079304.8718.7.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201104070344.44568.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 April 2011, Catalin Marinas wrote:
> On Wed, 2011-04-06 at 00:19 +0100, Linus Walleij wrote:
> > 2011/4/1 Linus Torvalds <torvalds@linux-foundation.org>:
> > Basically it requires you to get the physical address and size of
> > each peripheral, then at offset -0x10 from the end address (usually
> > at even 4K pages), if you find the magic number 0xB105F00D
> > (ARM has a sense of humour, obviously) you can find something
> > alike the PCI IDs at offset -0x20, manufacturer ID, version number
> > and revision of the hardware.
> 
> I don't think this was ever part of the AMBA specification. It was just
> some convention used within ARM for the PrimeCell peripherals. Other
> AMBA licensees did something else so it's not a reliable mechanism (I
> think ARM gave up on this as well in recent peripherals).

Do you think there is a way to get ARM ltd to make a better effort
at this with a future specification? I suppose it would be extremely
helpful if there was a way to specify more of the required information,
and to require everybody to fill in correct data, in the same way that
architecture compliance gets enforced on the CPU core.

	Arnd
