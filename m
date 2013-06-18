From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 16:15:27 +0200
Subject: DMA mapping API(IOMMU) for ARM64?
In-Reply-To: <20130618125054.GL9930@arm.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
 <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
 <20130618125054.GL9930@arm.com>
Message-ID: <201306181615.27341.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Catalin Marinas wrote:
> > 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)
> > 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> > 3, Factor out the common code from them into mm/dma-mapping.c
> 
> Or add the relevant code to something like lib/iommu-helper.c, convert
> arm64 to use that and we can work on converting arm and other
> architectures afterwards.

Yes, that would work too.

	Arnd
