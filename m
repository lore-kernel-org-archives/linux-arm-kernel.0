From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 16:47:59 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <cover.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Message-ID: <20150123164759.GF9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 08:48:52PM +0000, Robin Murphy wrote:
> Catalin Marinas (1):
>   arm64: Combine coherent and non-coherent swiotlb dma_ops
> 
> Robin Murphy (4):
>   arm64: implement generic IOMMU configuration
>   iommu: implement common IOMMU ops for DMA mapping
>   arm64: add IOMMU dma_ops
>   arm64: hook up IOMMU dma_ops

I queued the first two patches in this series for 3.20. The rest need to
go through some review rounds.

Thanks.

-- 
Catalin
