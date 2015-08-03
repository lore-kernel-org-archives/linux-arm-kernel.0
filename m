From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Aug 2015 18:40:10 +0100
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150803174010.GE11772@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:18:27PM +0100, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
