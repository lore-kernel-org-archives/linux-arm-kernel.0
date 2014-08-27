From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 27 Aug 2014 09:51:15 +0300
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Tegra AHCI driver
Message-ID: <1409122275-16464-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables AHCI_TEGRA by default. This driver is required
for Serial ATA support on Tegra124-based boards.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..affd9ee 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -132,6 +132,7 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_ST=y
 CONFIG_AHCI_SUNXI=y
+CONFIG_AHCI_TEGRA=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
-- 
1.8.1.5
