From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:15:33 +0000
Subject: [PATCH 0/4] iommu/arm-smmu: current updates for 4.1
Message-ID: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I only have a small handful of arm-smmu patches on the radar for 4.1,
so here they are in case anybody has any comments.

Cheers,

Will

--->8

Robin Murphy (1):
  iommu/arm-smmu: set a more appropriate DMA mask

Will Deacon (3):
  iommu/arm-smmu: ensure CBA2R is initialised before CBAR on SMMUv2
  iommu/arm-smmu: handle multi-alias IOMMU groups for PCI devices
  iommu/io-pgtable-arm: avoid speculative walks through TTBR1

 drivers/iommu/arm-smmu.c       | 125 ++++++++++++++++++++++++++---------------
 drivers/iommu/io-pgtable-arm.c |   5 ++
 2 files changed, 85 insertions(+), 45 deletions(-)

-- 
2.1.4
