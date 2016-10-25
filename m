From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 25 Oct 2016 23:36:09 +0530
Subject: [PATCH 0/3] drivers: iommu: declare iommu_gather_ops structures as
 const
Message-ID: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify iommu_gather_ops structures and replace __initdata with
__initconst where needed.

Bhumika Goyal (3):
  drivers: iommu: arm-smmu: constify iommu_gather_ops structures
  drivers: iommu: arm-smmu-v3: constify iommu_gather_ops structures
  drivers: iommu: io-pgtable-arm: use const and __initconst for
    iommu_gather_ops structures

 drivers/iommu/arm-smmu-v3.c    | 2 +-
 drivers/iommu/arm-smmu.c       | 2 +-
 drivers/iommu/io-pgtable-arm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
