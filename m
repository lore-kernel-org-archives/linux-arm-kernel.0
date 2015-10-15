From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 16:04:18 +0100
Subject: [PATCH 0/6] iommu/arm-smmu: Updates for 4.4
Message-ID: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are the ARM SMMU updates I have queued for 4.4. I'm away next week,
so I'll send a corresponding pull request shortly.

Will

--->8

Fabio Estevam (1):
  iommu/arm-smmu: Remove unneeded '0x' annotation

Marc Zyngier (1):
  iommu/arm-smmu: Add support for MSI on SMMUv3

Tirumalesh Chalamarla (1):
  iommu/arm-smmu: ThunderX mis-extends 64bit registers

Will Deacon (3):
  iommu/arm-smmu: Use drvdata instead of maintaining smmu_devices list
  iommu/arm-smmu: fix error checking for ASID and VMID allocation
  iommu/arm-smmu: remove redundant calculation of gr0 base address

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  19 +++
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/arm-smmu-v3.c                        | 154 +++++++++++++++------
 drivers/iommu/arm-smmu.c                           |  55 ++++----
 4 files changed, 159 insertions(+), 70 deletions(-)

-- 
2.1.4
