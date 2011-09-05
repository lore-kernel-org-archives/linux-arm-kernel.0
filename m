From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Sep 2011 17:06:46 +0200
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <201109051635.59927.arnd@arndb.de>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20110822130942.23830.4767.stgit@e102602-lin.cambridge.arm.com>
	<201109051635.59927.arnd@arndb.de>
Message-ID: <201109051706.46409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 September 2011, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
> > index f05bcdf..aa97d18 100644
> > --- a/arch/arm/mach-realview/include/mach/io.h
> > +++ b/arch/arm/mach-realview/include/mach/io.h
> > @@ -20,9 +20,25 @@
> >  #ifndef __ASM_ARM_ARCH_IO_H
> >  #define __ASM_ARM_ARCH_IO_H
> >  
> > +#include <asm/mach-types.h>
> > +#include <mach/hardware.h>
> > +
> >  #define IO_SPACE_LIMIT 0xffffffff
> 
> The IO_SPACE_LIMIT should match the REALVIEW_PB_PCI_IO_BASE above.
> 
This obviously should be REALVIEW_PB_PCI_IO_SIZE.

	Arnd
