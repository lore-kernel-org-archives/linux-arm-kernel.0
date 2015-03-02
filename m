From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 20:33:51 +0100
Subject: [PATCH] ARM: at91: remove NEED_MACH_IO_H
In-Reply-To: <20150302132234.GP4094@piout.net>
References: <2695765.t2RUmlZpTO@wuerfel> <20150302132234.GP4094@piout.net>
Message-ID: <2648850.fGrpMEv72l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 14:22:34 Alexandre Belloni wrote:
> On 02/03/2015 at 14:09:57 +0100, Arnd Bergmann wrote :
> > The mach/io.h header on at91 is used to support a nonstandard I/O space
> > window for the cf card driver. This changes the driver to use pci_ioremap_io
> > in order to have the standard location, and then removes the custom
> > mach/io.h.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ----
> > I've found this patch in an old git tree of mine. I think it's still needed,
> > but see for yourselves.
> > 
> 
> Do you think we can take it through the at91 tree? I think my previous
> patch went through arm-soc.
> 
> If yes, I'll include it in the multiplatform series to reduce the number
> of conflicts in Kconfig.

Yes, I think that would be good.
	
	Arnd
