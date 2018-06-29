From: lsun@mellanox.com (Liming Sun)
Date: Fri, 29 Jun 2018 10:45:26 -0400
Subject: [PATCH v1 1/1] arm64: defconfig: Enable dw_mmc-bluefield driver
Message-ID: <0a5fbadb025116d22e8ee939c4b2f1dcbf118fa2.1530281777.git.lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates arm64 defconfig to enable dw_mmc-bluefield,
which is a driver extension of Synopsys Designware MMC for the
Mellanox BlueField Soc.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f..83de504 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -497,6 +497,7 @@ CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
+CONFIG_MMC_DW_BLUEFIELD=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_HI3798CV200=y
 CONFIG_MMC_DW_K3=y
-- 
1.8.3.1
