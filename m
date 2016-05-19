From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 May 2016 14:11:34 +0200
Subject: [PATCH] arm64: configs: enable PCIe driver for Armada 7K/8K
Message-ID: <1463659894-20585-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the driver for the PCIe host controller found on
the Marvell Armada 7K/8K ARM64 SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0bd559a..23821c2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -63,6 +63,7 @@ CONFIG_PCI_XGENE=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
+CONFIG_PCIE_ARMADA_8K=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
-- 
2.7.4
