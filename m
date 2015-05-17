From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 17 May 2015 09:53:32 +0200 (CEST)
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <20150516205103.GO2067@n2100.arm.linux.org.uk>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <1431769465-26867-9-git-send-email-stefan@agner.ch>
 <20150516205103.GO2067@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1505170952060.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 May 2015, Russell King - ARM Linux wrote:

> On Sat, May 16, 2015 at 11:44:20AM +0200, Stefan Agner wrote:
> > Remove the needless differences between MMU/!MMU addruart calls.
> > This allows to use the same addruart macro on SoC level. Useful
> > for SoC consisting of multiple CPUs with and without MMU such as
> > Freescale Vybrid.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Depending on the merge plan for the remainder (has tglx reviewed the IRQ
> changes yet?  I think he needs to before this can be merged)... if it's
> not going to go in for the next merge window, this should find its way
> into the patch system so it can be applied anyway.

I'm going to apply the irq core and chip driver modifications to a
separate branch later today, so you or ARM-SOC folks can pull that
in. Will send you a mail where it can be found.

Thanks,

	tglx
