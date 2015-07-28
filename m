From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jul 2015 18:30:07 +0100
Subject: [PATCH v4 4/4] arm64: Hook up IOMMU dma_ops
In-Reply-To: <fecbcc50e62ae86639c886ab86e4ec067d52b16a.1437070995.git.robin.murphy@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
 <fecbcc50e62ae86639c886ab86e4ec067d52b16a.1437070995.git.robin.murphy@arm.com>
Message-ID: <20150728173006.GC536@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 07:40:15PM +0100, Robin Murphy wrote:
> With iommu_dma_ops in place, hook them up to the configuration code, so
> IOMMU-fronted devices will get them automatically.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
