From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 13:37:45 +0000
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <20100325210409.GH24984@n2100.arm.linux.org.uk>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
Message-ID: <1269610665.807.51.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-25 at 21:04 +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 24, 2010 at 09:11:56AM -0600, Grant Likely wrote:
> > ===Required System State===
[...]
> > *IRQs disabled
> > *MMU off
> > *Instruction cache either on or off
> > *Data cache turned off
> 
> Would recommend saying "Data cache(s) turned off" so that L2 cache is
> included.

There are platforms where the L2 cache is turned on by the boot monitor
(secure monitor) and Linux has no control over it (I think OMAP).

-- 
Catalin
