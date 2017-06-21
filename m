From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 21 Jun 2017 12:30:46 -0500
Subject: [PATCH 7/8] arm64: defconfig: enable QCOM_L2_PMU and QCOM_L3_PMU
In-Reply-To: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
References: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
Message-ID: <1498066247-22130-8-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drivers are available, enable support for L2 and L3
performance monitoring Qualcomm Datacenter Technologies Centriq SoCs.
These PMU drivers provide support for performance optimization.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a52906..00a0f80 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -502,6 +502,8 @@ CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_QCOM_L2_PMU=y
+CONFIG_QCOM_L3_PMU=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_CAPSULE_LOADER=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
