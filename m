From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 14 Dec 2017 16:58:49 +0000
Subject: [PATCH v2 0/4] SMMU 52-bit address support
Message-ID: <cover.1512038236.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's a (hopefully final) update of 52-bit SMMU support. The only
material changes from v1[1] are a small cosmetic tweak to patch #1,
and correction of the silly error in patch #2 as reported by Nate in
testing.

Robin.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-November/025073.html

Robin Murphy (4):
  iommu/arm-smmu-v3: Clean up address masking
  iommu/io-pgtable-arm: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit virtual address

 drivers/iommu/arm-smmu-v3.c    | 76 ++++++++++++++++++++++--------------------
 drivers/iommu/io-pgtable-arm.c | 65 ++++++++++++++++++++++++++----------
 2 files changed, 86 insertions(+), 55 deletions(-)

-- 
2.13.4.dirty
