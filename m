From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Jun 2015 07:02:08 +0200
Subject: [PATCH] arm64: defconfig: Add Ceva ahci to the defconfig
Message-ID: <457a921583db64bf74ae13b227bedf79cf86cff8.1435554123.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suneel Garapati <suneel.garapati@xilinx.com>

The Ceva ahci controller is available on the Xilinx Zynq UltraScale+
MPSoC.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f38c94f1d898..ef5b5d27a226 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -35,10 +35,10 @@ CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
-CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
@@ -82,7 +82,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
-CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_XGENE=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
-- 
2.3.5
