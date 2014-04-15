From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 Apr 2014 17:00:06 +0200
Subject: [PATCHv3 5/5] ARM: configs: add ahci_mvebu to multi_v7_defconfig
In-Reply-To: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397574006-5868-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
index d4e8a47..59f7ede 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -116,6 +116,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
+CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
-- 
1.9.2
