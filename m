From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 8 Jan 2010 17:06:09 -0600
Subject: [PATCH] armv6: invalidate cache on
	DMA_FROM_DEVICE/DMA_BIDIRECTIONAL
In-Reply-To: <20091221124438.GC11669@n2100.arm.linux.org.uk>
References: <1261357222-18470-1-git-send-email-jamie.iles@picochip.com>
	<1261386497-2924-1-git-send-email-jamie.iles@picochip.com>
	<1261386497-2924-2-git-send-email-jamie.iles@picochip.com>
	<20091221124438.GC11669@n2100.arm.linux.org.uk>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A85EB687@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
> Sent: Monday, December 21, 2009 6:45 AM

> I was thinking about doing this for ARMv6, but I thought the concensus
> was that ARMv6 didn't have speculative prefetching.

If you bolt on a unified L2 cache won't normal branch prediction result in some possible erroneous data in L2 cache range (assume mmu execution flag is set I suppose)?

Regards,
Richard W.
