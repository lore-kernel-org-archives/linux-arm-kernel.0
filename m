From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Jan 2012 09:42:37 +0100
Subject: [PATCH 0/8 v4] ARM: DMA-mapping framework redesign
In-Reply-To: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
References: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <012601cccf73$ce09a8f0$6a1cfad0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

To help everyone in testing and adapting our patches for his hardware 
platform I've rebased our patches onto the latest v3.2 Linux kernel and
prepared a few GIT branches in our public repository. These branches
contain our memory management related patches posted in the following
threads:

"[PATCHv18 0/11] Contiguous Memory Allocator":
http://www.spinics.net/lists/linux-mm/msg28125.html
later called CMAv18,

"[PATCH 00/14] DMA-mapping framework redesign preparation":
http://www.spinics.net/lists/linux-sh/msg09777.html
and
"[PATCH 0/8 v4] ARM: DMA-mapping framework redesign":
http://www.spinics.net/lists/arm-kernel/msg151147.html
with the following update:
http://www.spinics.net/lists/arm-kernel/msg154889.html
later called DMAv5.

These branches are available in our public GIT repository:

git://git.infradead.org/users/kmpark/linux-samsung
http://git.infradead.org/users/kmpark/linux-samsung/

The following branches are available:

1) 3.2-cma-v18
Vanilla Linux v3.2 with fixed CMA v18 patches (first patch replaced
with the one from v17 to fix SMP issues, see the respective thread).

2) 3.2-dma-v5
Vanilla Linux v3.2 + iommu/next (IOMMU maintainer's patches) branch
with DMA-preparation and DMA-mapping framework redesign patches.

3) 3.2-cma-v18-dma-v5
Previous two branches merged together (DMA-mapping on top of CMA)

4) 3.2-cma-v18-dma-v5-exynos
Previous branch rebased on top of iommu/next + kgene/for-next (Samsung
SoC platform maintainer's patches) with new Exynos4 IOMMU driver by 
KyongHo Cho and relevant glue code.

5) 3.2-dma-v5-exynos
Branch from point 2 rebased on top of iommu/next + kgene/for-next 
(Samsung SoC maintainer's patches) with new Exynos4 IOMMU driver by 
KyongHo Cho and relevant glue code.

I hope everyone will find a branch that suits his needs. :)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
