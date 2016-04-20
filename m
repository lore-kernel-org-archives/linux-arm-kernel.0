From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Apr 2016 14:53:31 +0100
Subject: [PATCH 0/2] iommu/arm-smmu: Fixed for 4.6
Message-ID: <1461160413-15403-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you take these two related arm-smmu fixes for 4.6? They
address a regression seem by both Eric and Yang following the partial
support for default domains that we added during the merge window.

I can send a pull request if you prefer, but it doesn't seem necessary
to me.

Thanks!

Will

--->8

Robin Murphy (1):
  iommu/arm-smmu: Don't allocate resources for bypass domains

Will Deacon (1):
  iommu/arm-smmu: Fix stream-match conflict with IOMMU_DOMAIN_DMA

 drivers/iommu/arm-smmu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.1.4
