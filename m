From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jun 2015 17:47:41 +0100
Subject: [PATCH 0/2] iommu/arm-smmu: fixes for 4.2
Message-ID: <1435596463-19247-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Since you're sending a batch of IOMMU fixes tomorrow, could you include
these two ARM SMMU fixes as well please?

Cheers,

Will

--->8

Markus Elfring (1):
  iommu/arm-smmu: Delete an unnecessary check before the function call
    "free_io_pgtable_ops"

Will Deacon (1):
  iommu/arm-smmu: Fix broken ATOS check

 drivers/iommu/arm-smmu-v3.c | 3 +--
 drivers/iommu/arm-smmu.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.1.4
