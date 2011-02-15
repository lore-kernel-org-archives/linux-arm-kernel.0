From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 14:23:39 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <1297777027.1293.2.camel@e102144-lin.cambridge.arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
	<20110212102803.GC15616@n2100.arm.linux.org.uk>
	<1297770742.21448.2.camel@e102144-lin.cambridge.arm.com>
	<20110215123522.GH4152@n2100.arm.linux.org.uk>
	<1297773569.14691.36.camel@e102109-lin.cambridge.arm.com>
	<1297777027.1293.2.camel@e102144-lin.cambridge.arm.com>
Message-ID: <20110215142339.GL4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 01:37:07PM +0000, Will Deacon wrote:
> I should've spotted this either way. I've superseded the old patch with
> 6674/1.

One additional thing that I think has been lost.  I said in the original
reply to Catalin:
| asm/memory.h will conflict non-trivially with p2v patch set, but I think
| we can merge the changes to everything but __virt_to_phys/__phys_to_virt.

So 6670/1 which I'm intending to apply to the p2v branch can't be merged
as-is.  The ideal solution would be a version of 6670/1 to apply on top
of the existing p2v branch.

Thanks.
