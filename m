From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 10:39:44 +0100
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable ST's (S)ATA driver
Message-ID: <1406021985-8763-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5348364..1a695a5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -127,6 +127,7 @@ CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_ST=y
 CONFIG_AHCI_SUNXI=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
-- 
1.8.3.2
