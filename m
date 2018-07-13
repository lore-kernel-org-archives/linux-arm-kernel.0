From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 13 Jul 2018 11:27:55 -0500
Subject: [PATCH 0/3] SOCFPGA Stratix10 SMMU Support
Message-ID: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series adds SMMU support to the SOCFPGA Stratix10 family
of parts. The addition of a clock parameter was required to ungate
the SMMU clock.

Thor Thayer (3):
  Docs: dt: arm-smmu: Add optional clock parameter
  iommu/arm-smmu: Add optional SMMU clock
  arm64: dts: stratix10: Add SMMU Node

 .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 44 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 17 +++++++++
 3 files changed, 77 insertions(+)

-- 
2.7.4
