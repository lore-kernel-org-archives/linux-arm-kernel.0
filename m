From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 28 Sep 2009 09:20:47 -0500
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <200909281610.32674.laurent.pinchart@ideasonboard.com>
References: <20090928092919.GA30271@localhost>	<20090928133109.GM30271@localhost>	<20090928134232.GG10671@n2100.arm.linux.org.uk>
	<200909281610.32674.laurent.pinchart@ideasonboard.com>
Message-ID: <4AC0C63F.9090503@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent Pinchart wrote:
> Do we really need a cross-architecture solution ? The pressure to implement a 
> working userspace DMA solution seem to come mostly from embedded system 
> developers, and embedded systems usually don't mind arch-specific APIs.
>   

So what if the first attempt is ARM-only?  Let the PPC guys have theirs, 
and so on--- all that experience should give us ideas on how to do the 
One Size Fits All version.  In the meantime, at least we'll have 
something we can use.

It's obviously a tricky problem to solve.  Think of the arch-specific 
version as being "prototype".  We'll be prototyping for a while, I'm 
sure, and the fact that we don't have such an API yet tells me that we 
need a few prototypes to identify how--- if it's even possible--- to 
proceed with a generic implementation.

> In that case developers will all create their own incompatible solutions and 
> the situation will likely get worse.

... and that creates the additional problem of cleaning up the mess 
while at the same time finding and implementing a cross-architecture 
solution.



b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
