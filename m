From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 15:30:09 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428135621.GE13402@8bytes.org>
References: <201104212129.17013.arnd@arndb.de>
	<20110428122508.GC13402@8bytes.org>
	<20110428124242.GJ17290@n2100.arm.linux.org.uk>
	<201104281502.16296.arnd@arndb.de>
	<20110428131928.GL17290@n2100.arm.linux.org.uk>
	<20110428135621.GE13402@8bytes.org>
Message-ID: <20110428143009.GO17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 03:56:21PM +0200, Joerg Roedel wrote:
> There is no waste of code, just the opposite. Most of the dma_ops
> implementations that use an IOMMU today have a lot of similiarities in
> their code. All this code (on x86, alpha, sparc, ia64, ...) can
> be unified to a generic solution that fits all (by abstracting the
> differences between iommus into the iommu-api). So the current situation
> is a much bigger code waste than having this unified. The ARM platforms
> supporting iommu hardware will benefit from this as well. It simply
> doesn't make sense to have one dma_ops implementation for each iommu
> hardware around.

I'll defer until there's patches available then - I don't think there's
much value continuing to discuss this until that time.
