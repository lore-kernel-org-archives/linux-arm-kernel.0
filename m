From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2018 10:50:49 +0800
Subject: [PATCH 2/2] arm64: defconfig: enable drivers for Poplar support
In-Reply-To: <1526007049-27884-1-git-send-email-shawn.guo@linaro.org>
References: <1526007049-27884-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1526007049-27884-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It enables driver support of Ethernet, eMMC, Combo/INNO phy and PCIe
for Hi3798CV200 Poplar platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index af0992f2fee7..78e3f1492b9b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -75,6 +75,7 @@ CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
+CONFIG_PCIE_HISI_STB=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR=y
@@ -206,6 +207,7 @@ CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
@@ -472,6 +474,7 @@ CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_MMC_DW_HI3798CV200=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
@@ -570,6 +573,8 @@ CONFIG_PWM_TEGRA=m
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_HI6220_USB=y
+CONFIG_PHY_HISTB_COMBPHY=y
+CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
1.9.1
