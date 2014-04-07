From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Apr 2014 16:57:44 +0200
Subject: [PATCH 4/4] ARM: configs: add ahci_mvebu to multi_v7_defconfig
In-Reply-To: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396882664-19297-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
for the AHCI interfaces, so this commit enables the corresponding
Kconfig option in multi_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index de52231..2a46e4b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -115,6 +115,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
+CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
-- 
1.8.3.2
