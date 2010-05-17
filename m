From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 12:08:11 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA3137B8@IL-MB01.marvell.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<1274089860.6053.0.camel@e102109-lin.cambridge.arm.com>
	<1274090255.6053.2.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3137B8@IL-MB01.marvell.com>
Message-ID: <1274094491.6053.32.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In case of Cortex-A9 (ARMv7), the TRM states clearly that it can do
> speculative loads into the L1 D-cache and this can be disabled via a bit
> in the auxiliary control register. Do you have a similar bit on your
> ARMv6 MP processor?
> 
> [Ronen Shitrit] Yes.

So, use it :)

-- 
Catalin
