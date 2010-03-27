From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 18:41:05 +0100
Subject: [PATCH 6/7 v2] Add common platform devices for TCC8xxx SoCs
In-Reply-To: <20100325203845.GG24984@n2100.arm.linux.org.uk>
References: <20100325200427.GC2047@bluebox.local>
	<20100325201649.GI2047@bluebox.local>
	<20100325203845.GG24984@n2100.arm.linux.org.uk>
Message-ID: <20100327174104.GG2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:38:45PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 09:16:50PM +0100, Hans J. Koch wrote:
> > +#include <linux/init.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/io.h>
> 
> linux/io.h

OK.

Thanks,
Hans
