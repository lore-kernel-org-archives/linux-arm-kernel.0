From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Mar 2010 15:43:27 +0000
Subject: [PATCH 03/11] Thumb-2: Implementation of the unified start-up
	and	exceptions code
In-Reply-To: <4B9E5020.2020706@users.sourceforge.net>
References: <20090602130549.12732.15147.stgit@pc1117.cambridge.arm.com>
	<4B9A7A3C.9000304@users.sourceforge.net>
	<20100312211614.GC1146@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003121640280.31128@xanadu.home>
	<4B9E5020.2020706@users.sourceforge.net>
Message-ID: <1268667807.18722.83.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-15 at 15:20 +0000, Anders Grafstr?m wrote:
> Nicolas Pitre wrote:
> > On Fri, 12 Mar 2010, Russell King - ARM Linux wrote:
> >
> >> So yes, your patch is absolutely required - all ARMv5 and below are
> >> facing a hazard as the kernel stands.  It might explain some of the
> >> weird behaviours people have been reporting as well.
> >>
> >> Please cleanup the description and submit to the patch system.
> >
> > And please add a small comment along side the otherwise seemingly
> > useless nop.
> 
> Done.
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5991/1
> 
BTW, should we have an #ifdef for __LINUX_ARM_ARCH__ >= 6? Not that it
would make a noticeable difference in speed.

-- 
Catalin
