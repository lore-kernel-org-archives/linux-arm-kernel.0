From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 21 Jun 2017 12:30:39 -0500
Subject: [v3][PATCH 0/8] arm64: defconfig: enable several options useful for
 ARM64 server platforms
Message-ID: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI-based ARM64 server platforms based, like the Qualcomm Datacenter
Technologies QDF2400, need several features and drivers enabled for
full functionality.  This patchset enables many of those features.

Timur Tabi (8):
  arm64: defconfig: enable ACPI_CPPC_CPUFREQ
  arm64: defconfig: enable BLK_DEV_NVME
  arm64: defconfig: enable EFI_CAPSULE_LOADER
  arm64: defconfig: enable support for PCIe hotplug
  arm64: defconfig: enable APEI and GHES features
  arm64: defconfig: enable EDAC options
  arm64: defconfig: enable QCOM_L2_PMU and QCOM_L3_PMU
  [v2] arm64: defconfig: enable Qualcomm Technologies EMAC and some PHY
    drivers

 arch/arm64/configs/defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
