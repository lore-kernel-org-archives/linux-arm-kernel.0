From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 17 Sep 2014 13:16:07 -0700
Subject: [PATCH 0/2] Add access-protected IOMMU mappings
Message-ID: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a new mapping flag to indicate that the mapping
should be created with access protection applied. Support for this new flag
is then added to the ARM SMMU driver.

Mitchel Humpherys (2):
  iommu: add IOMMU_PRIV flag for access-protected mappings
  iommu/arm-smmu: add support for access-protected mappings

 drivers/iommu/arm-smmu.c | 5 +++--
 include/linux/iommu.h    | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
