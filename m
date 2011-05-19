From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 May 2011 15:50:19 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <BANLkTinXQvrG3LeSEO9Lnam3Bvq3dDKOsw@mail.gmail.com>
References: <201105181047.17309.arnd@arndb.de>
	<alpine.LFD.2.00.1105182234130.14430@xanadu.home>
	<BANLkTinXQvrG3LeSEO9Lnam3Bvq3dDKOsw@mail.gmail.com>
Message-ID: <201105191550.20129.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 May 2011, Barry Song wrote:
> 2011/5/19 Nicolas Pitre <nico@fluxnic.net>:
> > On Thu, 19 May 2011, Barry Song wrote:
> > Something like that.  The exact details will be fleshed out as we go.
> > The idea is to give a round of review from a higher point of view to
> > make sure no opportunities for code reuse is missed, etc.  The mechanics
> > of how this code transitions from this tree into mainline during the
> > merge window is secondary.
> 
> i asked this because we wanted to send the source codes of
> CSR(http://www.csr.com) to upstream as i have told you in LDS. it
> looks like we need to follow the below new changes to make our source
> codes acceptable?
> 1. arm device tree
> 2. new pinmux framework from Linus Walleij
> 3. move GPIO from plat/mach to drivers/gpio?

I would count at least the last two as mandatory, for the device tree,
it depends on how much work it would be for you to do the conversion
and at what time you submit the series. The longer you wait before
submitting the series, the stricter the requirements will get.

Do you have a diffstat or a git tree with your work available?

	Arnd
