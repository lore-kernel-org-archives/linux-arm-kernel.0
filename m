From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 May 2017 11:48:02 +0530
Subject: [PATCH] dmaengine: pl330: Add IOMMU support to slave tranfers
In-Reply-To: <c10016eb9d96d80afcacf547b8a9ec47c6a4cb21.1495202642.git.robin.murphy@arm.com>
References: <c10016eb9d96d80afcacf547b8a9ec47c6a4cb21.1495202642.git.robin.murphy@arm.com>
Message-ID: <20170530061757.GK15061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 03:06:44PM +0100, Robin Murphy wrote:
> Wire up dma_map_resource() for slave transfers, so that we can let the
> PL330 use IOMMU-backed DMA mapping ops on systems with an appropriate
> IOMMU and RAM above 4GB, to avoid CPU bounce buffering.

Applied, thanks


-- 
~Vinod
