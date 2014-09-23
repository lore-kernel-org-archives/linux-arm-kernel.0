From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 23 Sep 2014 13:21:40 -0500
Subject: [PATCH 1/2] ARM: qcom: Update defconfig
Message-ID: <1411496501-20130-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable ATA & AHCI platform support to get SATA on IPQ806x platforms

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da33..05372f1 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -57,13 +57,14 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_MDIO_BITBANG=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
