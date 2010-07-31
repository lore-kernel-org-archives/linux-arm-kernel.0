From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 31 Jul 2010 12:30:49 +1000
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1280543449.1902.29.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-29 at 12:35 +0900, FUJITA Tomonori wrote:
> Don't confuse the IOMMU interface with the DMA API that Arnd
> mentioned.
> 
> They are not related at all.
> 
> The DMA API is defined in Documentation/DMA-API.txt.
> 
> Arnd told you that include/asm-generic/dma-mapping-common.h is the
> library to support the DMA API with multiple IOMMUs. Lots of
> architectures (x86, powerpc, sh, alpha, ia64, microblaze, sparc)
> use it. 

Also, some of the iommu layer actually originates from powerpc.

Cheers,
Ben.
