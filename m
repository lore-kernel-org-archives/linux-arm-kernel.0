From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 4 Jun 2014 14:32:39 +0300
Subject: [PATCH 9/9] ARM: tegra: Add options for Tegra AHCI support to
 tegra_defconfig
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1401881559-18469-10-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds ATA, SATA_AHCI and AHCI_TEGRA support to tegra_defconfig
so that the SATA support will be automatically enabled.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index fb25e29..6516f46 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -109,6 +109,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_AHCI_TEGRA=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_R8169=y
-- 
1.8.1.5
