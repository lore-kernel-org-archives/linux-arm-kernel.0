From: rshitrit@marvell.com (Ronen Shitrit)
Date: Sun, 16 May 2010 09:29:47 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6
	DMA cache ops
In-Reply-To: <1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
Message-ID: <309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our ARMv6 do speculative rd for both I and D cache...

Regards

-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Thursday, May 13, 2010 11:27 AM
To: Ronen Shitrit
Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6 DMA cache ops

On Thu, 2010-05-13 at 06:27 +0100, Ronen Shitrit wrote:
> Our ARM v6 does have speculative prefetch...

That's the I-cache and we should be ok with it. What may affect this
patch is speculative fetches into the D-cache.

-- 
Catalin
