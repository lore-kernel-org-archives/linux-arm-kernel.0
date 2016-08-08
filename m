From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  8 Aug 2016 18:13:08 +0200
Subject: [PATCH] arm64: configs: enable PCIe driver for Aardvark
Message-ID: <1470672788-13652-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the driver for the PCIe host controller found on the
Marvell Armada 3700 ARM64 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 423a1cc91224..03cecc68df68 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -58,6 +58,7 @@ CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_IOV=y
+CONFIG_PCI_AARDVARK=y
 CONFIG_PCIE_RCAR=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
-- 
2.8.1
