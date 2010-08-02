From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Aug 2010 10:03:26 +0100
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802172941C.fujita.tomonori@lab.ntt.co.jp>
References: <1280546124.1902.30.camel@pasglop> <20100802074812.GM24084@amd.com>
	<1280736182.1902.55.camel@pasglop>
	<20100802172941C.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100802090326.GA30670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 05:30:26PM +0900, FUJITA Tomonori wrote:
> ARM's iommu code (arch/plat-omap/include/plat/iommu.h) is a library to
> simplify the IOMMU implementations. It could be useful for all the
> iommu implementations.

ITYM OMAP's iommu code.
