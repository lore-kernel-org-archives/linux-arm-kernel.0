From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 17:33:54 +0100
Subject: [PATCH 3/7 v2] Introduce plat-tcc irq framework
In-Reply-To: <20100325203307.GD24984@n2100.arm.linux.org.uk>
References: <20100325200427.GC2047@bluebox.local>
	<20100325201057.GF2047@bluebox.local>
	<20100325203307.GD24984@n2100.arm.linux.org.uk>
Message-ID: <20100327163354.GD2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:33:07PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 09:10:58PM +0100, Hans J. Koch wrote:
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/ptrace.h>
> > +
> > +#include <asm/irq.h>
> > +#include <asm/mach/irq.h>
> > +#include <asm/io.h>
> 
> linux/io.h

Yep, and <linux/sched.h>, <linux/interrupt.h>, and <linux/ptrace.h> are not
needed at all. Fixed.

Thanks,
Hans
