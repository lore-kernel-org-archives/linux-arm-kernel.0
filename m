From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Aug 2015 18:33:48 +0100
Subject: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
In-Reply-To: <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150803173348.GD11772@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:18:28PM +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Unfortunately the device setup code has to start out as a big ugly mess
> in order to work usefully right now, as 'proper' operation depends on
> changes to device probe and DMA configuration ordering, IOMMU groups for
> platform devices, and default domain support in arm/arm64 IOMMU drivers.
> The workarounds here need only exist until that work is finished.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
